#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
AGENTS_DIR="$( cd "$DIR/../agents" && pwd)"
# shellcheck source=../lib.sh
source "$DIR/../lib.sh"

emoji='🔗'

# Create symbolic links for the dotfiles from this directory
info "Creating symbolic links for configuration files."

ZSH=".zshrc"
log "$emoji Linking $ZSH"
ln -f "$DIR/$ZSH" "$HOME/$ZSH"

TMUX=".tmux.conf"
log "$emoji Linking $TMUX"
ln -f "$DIR/$TMUX" "$HOME/$TMUX"

NVIM="init.vim"
log "$emoji Linking $NVIM"
ln -f "$DIR/$NVIM" "$HOME/.config/nvim/$NVIM"

GIT=".gitconfig"
log "$emoji Linking $GIT"
ln -f "$DIR/$GIT" "$HOME/$GIT"

PHOENIX=".phoenix.js"
log "$emoji Linking $PHOENIX"
ln -f "$DIR/$PHOENIX" "$HOME/$PHOENIX"

RANGER="ranger/rc.conf"
log "$emoji Linking $RANGER"
ln -f "$DIR/$RANGER" "$HOME/.config/$RANGER"

SKILLS_REPO="$( cd "$DIR/../../skills" 2>/dev/null && pwd )"
if [ -z "$SKILLS_REPO" ] || [ ! -d "$SKILLS_REPO/skills" ]; then
  warning "$emoji Skipping skills — clone github.com/witekbobrowski/skills next to dotfiles first"
else
  link_skills() {
    local target="$1"
    if [ -d "$target" ] && [ ! -L "$target" ] && [ -n "$(ls -A "$target")" ]; then
      warning "$emoji Skipping $target — non-empty real directory, move its contents into $SKILLS_REPO/skills first"
      return
    fi
    mkdir -p "$(dirname "$target")"
    rm -rf "$target"
    ln -s "$SKILLS_REPO/skills" "$target"
    log "$emoji Linked $target"
  }
  log "$emoji Linking skills from $SKILLS_REPO"
  link_skills "$HOME/.claude/skills"
  link_skills "$HOME/.agents/skills"
fi

log "$emoji Linking AGENTS.md"
ln -sf "$AGENTS_DIR/AGENTS.md" "$HOME/.claude/CLAUDE.md"

mkdir -p "$HOME/.codex"
ln -sf "$AGENTS_DIR/AGENTS.md" "$HOME/.codex/AGENTS.md"

CODEX_ROLE_CONFIGS="codex"
log "$emoji Linking codex role configs"
ln -sf "$AGENTS_DIR/$CODEX_ROLE_CONFIGS/scout.config.toml" "$HOME/.codex/scout.config.toml"
ln -sf "$AGENTS_DIR/$CODEX_ROLE_CONFIGS/implementer.config.toml" "$HOME/.codex/implementer.config.toml"

write_codex_config() {
  local versioned="$AGENTS_DIR/codex/config.toml"
  local target="$HOME/.codex/config.toml"
  local tmp

  if [ ! -f "$versioned" ]; then
    error "$emoji Missing $versioned, leaving $target untouched"
    return 1
  fi

  tmp="$(mktemp)" || return 1
  cat "$versioned" > "$tmp"

  if [ -f "$target" ]; then
    local projects_start
    projects_start="$(awk '/^\[projects\./{print NR; exit}' "$target")"
    if [ -n "$projects_start" ]; then
      {
        echo ""
        echo "# Machine-local below this line (written by Codex, not versioned)"
        tail -n "+$projects_start" "$target"
      } >> "$tmp"
    fi
  fi

  # Anything Codex wrote above its [projects.*] block (e.g. a model picked in
  # the TUI) is intentionally dropped: the versioned file is the source of truth.
  if mv "$tmp" "$target"; then
    log "$emoji Wrote $target"
  else
    error "$emoji Could not write $target"
    rm -f "$tmp"
    return 1
  fi
}

log "$emoji Writing codex config"
write_codex_config

CLAUDE_SETTINGS="claude/settings.json"
log "$emoji Linking $CLAUDE_SETTINGS"
ln -sf "$AGENTS_DIR/$CLAUDE_SETTINGS" "$HOME/.claude/settings.json"

CLAUDE_AGENTS="claude/agents"
log "$emoji Linking $CLAUDE_AGENTS"
# Remove existing agents directory if it exists
rm -rf "$HOME/.claude/agents"
# Create symlink for Claude agent definitions
ln -s "$AGENTS_DIR/$CLAUDE_AGENTS" "$HOME/.claude/agents"

success "Done creating symbolic links!"

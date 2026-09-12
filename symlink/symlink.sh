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

CLAUDE_MD="claude/CLAUDE.md"
log "$emoji Linking $CLAUDE_MD"
ln -sf "$AGENTS_DIR/$CLAUDE_MD" "$HOME/.claude/CLAUDE.md"

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

# dotfiles — repo guidance

Personal macOS dotfiles, agentic-coding first. Four top-level areas:

- `agents/`: versioned config for both harnesses, symlinked into `~/.claude/` and `~/.codex/`. `AGENTS.md` is the shared instructions file, symlinked to both `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`. `claude/` holds Claude Code's config (`settings.json`, `agents/`). `codex/` holds Codex's config (`config.toml`, per-role `scout.config.toml`/`implementer.config.toml`); `~/.codex/config.toml` is *generated*, not symlinked, because Codex mutates it at runtime (appending `[projects.*]` trust entries), and a symlink into the repo would let that machine-local state leak into version control. Skills live in the sibling repo `../skills` and are symlinked into `~/.claude/skills` and `~/.agents/skills`.
- `symlink/`: symlink scripts, non-AI dotfile sources (`.zshrc`, `.tmux.conf`, `.gitconfig`, `.phoenix.js`, `init.vim`, iTerm2 plist), and `symlink.sh`.
- `apps/`: Homebrew, Cask, Mac App Store, gem, and yarn manifests plus the install script for them.
- `defaults/`: macOS `defaults write` scripts (shell, macOS, Safari, Photos, iTerm2, Transmission, directories, wallpaper).

## Key invariant

Files under `agents/claude/` and `symlink/` are **live**: they're symlinked straight into `$HOME` and `~/.claude`. Editing them in place changes the running system immediately. Moving or renaming any of them breaks the corresponding symlink until `symlink/symlink.sh` is re-run to relink. An edit here is not "just in the repo"; it's also the config currently in effect.

## Conventions

- Shell scripts source the repo-root `lib.sh` for logging helpers (`log`, `info`, `success`, `warning`, `error`); don't reimplement logging inline.
- `install.sh` at the repo root is the top-level orchestrator; it calls the `defaults/` scripts, then `symlink/symlink.sh`, then `apps/apps.sh`, in that order.
- Path construction in `symlink/symlink.sh` uses `cd ... && pwd` to resolve absolute directories (`DIR`, `AGENTS_DIR`) rather than relying on relative paths at use-site. Match that pattern if you add new linked targets.
- Never commit changes in this repo unless explicitly asked to.

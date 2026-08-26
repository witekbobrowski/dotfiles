# dotfiles — repo guidance

Personal macOS dotfiles, agentic-coding first. Four top-level areas:

- `ai/` — versioned Claude Code configuration (`CLAUDE.md`, `agents/`, `commands/`) that gets symlinked into `~/.claude/`.
- `symlink/` — symlink scripts, non-AI dotfile sources (`.zshrc`, `.tmux.conf`, `.gitconfig`, `.phoenix.js`, `init.vim`, iTerm2 plist, ranger config), and `symlink.sh`.
- `apps/` — Homebrew, Cask, Mac App Store, gem, and yarn manifests plus the install script for them.
- `defaults/` — macOS `defaults write` scripts (shell, macOS, Safari, Photos, iTerm2, Transmission, directories, wallpaper).

## Key invariant

Files under `ai/claude/` and `symlink/` are **live** — they're symlinked straight into `$HOME` and `~/.claude`. Editing them in place changes the running system immediately. Moving or renaming any of them breaks the corresponding symlink until `symlink/symlink.sh` is re-run to relink. Never assume an edit here is "just in the repo" — it's also the config currently in effect.

## Conventions

- Shell scripts source the repo-root `lib.sh` for logging helpers (`log`, `info`, `success`, `warning`, `error`) — don't reimplement logging inline.
- `install.sh` at the repo root is the top-level orchestrator; it calls the `defaults/` scripts, then `symlink/symlink.sh`, then `apps/apps.sh`, in that order.
- Path construction in `symlink/symlink.sh` uses `cd ... && pwd` to resolve absolute directories (`DIR`, `AI_DIR`) rather than relying on relative paths at use-site — match that pattern if you add new linked targets.
- Never commit changes in this repo unless explicitly asked to.

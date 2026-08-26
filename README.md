# dotfiles

Personal macOS dotfiles, built agentic-coding first. The AI layer is the centerpiece; the classic shell/editor/window-manager configuration exists to support it.

## AI layer

The main session runs on **Fable**, which handles planning, task decomposition, and reviewing results rather than doing bulk reading or writing itself. `scout` (Haiku) is dispatched for reconnaissance — searching, reading files, answering "where is X / how does Y work" questions. `implementer` (Sonnet) picks up anything that clearly needs code written once the approach is decided: edits, new files, refactors, mechanical migrations. `codex` and `codex-reviewer` wrap the locally installed OpenAI Codex CLI for, respectively, self-contained one-shot tasks and cross-vendor review of a finished diff — a second model family catches blind spots same-family review misses. The rule of thumb is an escalation ladder: start with the cheapest capable agent and move up only on a concrete failure signal (tests fail, the worker reports being stuck, review turns up a real problem) — never on vague dissatisfaction with style.

| Agent | Model | Role |
|---|---|---|
| `scout` | Haiku | Reconnaissance and search |
| `implementer` | Sonnet | Writes code — edits, refactors, new files |
| `codex` | OpenAI Codex CLI | Self-contained, one-shot tasks |
| `codex-reviewer` | OpenAI Codex CLI | Cross-vendor review of a finished diff |

Three slash commands live alongside the agents:

- `/commit` — stages and commits changes, matching the repo's detected commit message conventions.
- `/create-pr` — opens a pull request with a title and description that follow the repo's PR conventions (template, title style, linked issues).
- `/review-pr-comments` — reads all PR review feedback, critically triages each comment into accept/reject/discuss, implements only what's genuinely worth doing, and replies to every comment with the reasoning.

Everything under `ai/claude/` (`CLAUDE.md`, `agents/`, `commands/`) is symlinked into `~/.claude/` by `symlink/symlink.sh`, so the entire AI setup — prompts, agent definitions, and commands — is versioned in this repo, not scattered in the home directory.

## Classic layer

- **Shell**: zsh, oh-my-zsh, Spaceship prompt
- **Editor**: Neovim
- **Multiplexer**: tmux
- **Git**: standard gitconfig plus `diff-so-fancy` for readable diffs
- **Terminal**: iTerm2
- **Window management**: Phoenix
- **File browser**: ranger

Package manifests (Homebrew, Cask, Mac App Store, gem, yarn) live in `apps/`. macOS system preference scripts live in `defaults/`.

## Repo layout

```
.
├── ai/                 # Versioned Claude Code configuration
│   └── claude/
│       ├── CLAUDE.md       # Global instructions for the main session
│       ├── agents/         # scout, implementer, codex, codex-reviewer
│       └── commands/       # /commit, /create-pr, /review-pr-comments
├── symlink/            # Dotfile sources + the symlink script
│   └── symlink.sh          # Links everything into $HOME / ~/.claude
├── apps/               # Brewfile, Caskfile, Masfile, Gemfile, Yarnfile
├── defaults/           # macOS defaults scripts (shell, macos, safari, ...)
├── lib.sh              # Logging helpers shared by the top-level scripts
└── install.sh          # Top-level installer
```

## Install

```
./install.sh
```

**Warning**: this overwrites existing configuration files and symlinks in your home directory without prompting. Read `install.sh` first if you're not running this on a fresh machine.

Each script under `defaults/` and `symlink/symlink.sh` can also be run standalone if you only want a subset of the setup.

## History

Started in 2018, inspired by [eivindml/dotfiles](https://github.com/eivindml/dotfiles) and [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles). Credit to [vyzyv](https://github.com/vyzyv) for general guidance on the setup, [eivindml](https://github.com/eivindml) for the repository structure, [nicknisi](https://github.com/nicknisi) for gitconfig and macOS defaults ideas, and [kevinSuttle](https://github.com/kevinSuttle/macOS-Defaults) for the macOS defaults reference. Redesigned in 2026 around agentic coding.

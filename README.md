# dotfiles

<p align=center>
<a href="">
<img alt="screenshot" src="https://user-images.githubusercontent.com/18266391/70084032-dad50180-160d-11ea-9553-766737b4d054.png">
</a>
</p>
<p align=center>
    <a href=""><img alt="OS" src="https://img.shields.io/badge/macOS-Tahoe-383838.svg"></a>
    <a href=""><img alt="Shell" src="https://img.shields.io/badge/Shell-zsh-blue.svg"></a>
    <a href=""><img alt="Terminal" src="https://img.shields.io/badge/Terminal-iTerm2-dark.svg"></a>
    <a href=""><img alt="Editor" src="https://img.shields.io/badge/Editor-Neovim-green.svg"></a>
    <a href=""><img alt="Agent" src="https://img.shields.io/badge/Agent-Claude-orange.svg"></a>
</p>

> Please note that this repository is no longer in its early stages. The best, apparently, has arrived — and it writes the code itself...

## About

This repository started back in 2018, when I received a MacBook from the company I was working for and found myself manually copying config files from my workstation at home. A quick `git init` later it became the usual dotfiles affair — zsh, Neovim, tmux, a pile of brew manifests — patiently maintained and occasionally riced.

Fast forward to 2026 and the way I write code has completely changed. Most days I am not typing into the editor — I am directing agents that do. So the repo got redesigned to reflect that: the AI configuration is no longer buried in a subdirectory like some `.plist` file, it is the headline act. Everything else is here to support it.

## AI first

The setup follows one rule: **the expensive model plans, the cheap models work**. The main Claude session runs on Fable and does the thinking — planning, decomposition, reviewing results. The labor is dispatched down the ladder:

| Agent | Model | Job |
|---|---|---|
| 🔍 `scout` | Haiku | Reconnaissance — find things, read things, report back |
| 🔨 `implementer` | Sonnet | Write the actual code once the approach is decided |
| 📦 `codex` | Codex CLI | Self-contained one-shot tasks, on a separate usage pool |
| 🧐 `codex-reviewer` | Codex CLI | Cross-vendor review — a second model family catches what the first one misses |

On top of that, three slash commands: `/commit`, `/create-pr` and `/review-pr-comments` — so the boring parts of shipping follow my conventions without me spelling them out every time.

All of it lives in `ai/claude/` and gets symlinked into `~/.claude/` by `symlink/symlink.sh`. The whole brain is versioned right here, not scattered around the home directory.

## The classics

The supporting cast, mostly unchanged since the ricing days: zsh with oh-my-zsh and Spaceship, Neovim, tmux, iTerm2, Phoenix for window management, ranger for browsing files, `diff-so-fancy` for git diffs. App manifests (brew, cask, mas, gem, yarn) live in `apps/`, macOS preference scripts in `defaults/`.

## Usage

#### 👨🏻‍💻 Automated

The most convenient way of applying this configuration to your system is to simply run the attached installation script `install.sh`.

```
$ ./install.sh
```

**`[!] Caution`** This will automatically override your configuration and install all the applications listed in `/apps` directory. This is basically for me only, for fast updating my own systems — if you really feel like running it, beware of the consequences of losing your configuration.

#### 👷🏻‍ Manual

The much safer way for anyone else: cherry-pick. Copy whole files or just the parts you like, and install only the apps you actually need.

## Contents

```
.
├── README.md
├── CLAUDE.md          # instructions for agents working on this repo
├── install.sh
├── lib.sh
├── ai
│   └── claude
│       ├── CLAUDE.md      # global instructions for the main session
│       ├── agents         # scout, implementer, codex, codex-reviewer
│       └── commands       # /commit, /create-pr, /review-pr-comments
├── apps
│   ├── Brewfile
│   ├── Caskfile
│   ├── Gemfile
│   ├── Masfile
│   ├── Yarnfile
│   └── apps.sh
├── defaults
│   ├── directories.sh
│   ├── iterm2.sh
│   ├── macos.sh
│   ├── photos.sh
│   ├── safari.sh
│   ├── shell.sh
│   ├── transmission.sh
│   └── wallpaper.sh
└── symlink
    ├── com.googlecode.iterm2.plist
    ├── init.vim
    └── symlink.sh
```

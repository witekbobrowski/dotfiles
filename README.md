# dotfiles

<p align=center>
<img alt="Mac Studio with a hello pin" src="assets/mac-studio-hello.jpg">
</p>

## About

This is the setup I build iOS apps with in 2026, kept in sync between a Mac Studio on the desk and a MacBook Air in the bag. The shell and macOS side has been here since 2018. What is new is the `agents/` directory: most of my code now goes through Claude Code and Codex, so their global instructions, settings and subagents are versioned here next to everything else, and the skills they share live in a separate [repository](https://github.com/witekbobrowski/skills). Clone both, run the install script, and either Mac ends up as the one in the photo.

This configuration runs on the following machines:

- 🖥 **Mac Studio** `M1 Ultra` `64 GB`
- 💻 **MacBook Air** `14"` `M2`

## Usage

On a fresh Mac, clone this repository and the [skills](https://github.com/witekbobrowski/skills) one next to each other, then run the installer:

```
$ ./install.sh
```

It applies the macOS defaults, links the dotfiles and agent config into `$HOME`, and installs every app from the manifests. It overwrites whatever config you already have, so this is really meant for my own machines. If you are someone else, copy the parts you like instead.

## Contents

```
.
├── install.sh      # runs everything below, in order
├── defaults        # macOS `defaults write` scripts
├── symlink         # dotfiles and the script that links them into $HOME
├── apps            # Homebrew, Cask, Mac App Store, gem and yarn manifests
└── agents          # Claude Code config, linked into ~/.claude
```

## Credits

Most of what is in here was learned from other people publishing their dotfiles on GitHub. Thank you, all of you. ✨

# Dotfiles

Personal Fedora/Linux dotfiles for my terminal-first development workflow.

This repo is centered on Fish, tmux, Neovim, and a small set of CLI tools I use every day. It is public for reference and backup, but it is still opinionated and machine-specific in a few places, so review before copying it directly onto your system.

## What this repo manages

- `fish` as the main shell
- `tmux` for terminal multiplexing
- `nvim` for editing
- `starship` for the prompt
- `atuin` for history
- `yazi` for file management
- `lazygit` and `lazydocker`
- terminal configs for `ghostty`, `alacritty`, and `wezterm`
- Git, htop, and a few extra app/env configs

## Supported environment

This setup currently assumes:

- Fedora or another `dnf`-based Linux distro
- an XDG-style config layout under `~/.config`
- GNOME in some places
- a Nerd Font, especially JetBrains Mono Nerd Font
- Homebrew/Linuxbrew for a few extra CLI packages

## Repository layout

- `.config/` - main XDG application configs
- `.config/fish/` - Fish config, aliases, functions, completions, and scripts
- `.config/nvim/` - Neovim config managed as a git submodule
- `.config/ghostty/` - Ghostty terminal config
- `.config/alacritty/` - Alacritty config
- `.config/git/` - Git config
- `.config/yazi/` - Yazi config
- `.tmux.conf` - upstream tmux base config
- `.tmux.conf.local` - personal tmux overrides
- `.vimrc` - fallback Vim config
- `.wezterm.lua` - WezTerm config
- `env-configs/` - extra app and environment config files
- `redis.conf` - standalone Redis config

## Core tools

Main tools I expect to have installed:

```bash
sudo dnf install fish tmux neovim git fzf zoxide starship ripgrep fd-find bat htop btop lazygit zoxide eza mpv procs gdu hyperfine
```

Useful clipboard tools for tmux and terminal workflows:

```bash
sudo dnf install wl-clipboard xclip xsel
```

Some tools I use come from Homebrew/Linuxbrew instead of `dnf`:

```bash
brew install atuin yazi duf dua tabiew topgrade
```

## Installation

Clone the repo with submodules so Neovim is pulled in too:

```bash
git clone --recurse-submodules <your-repo-url> ~/dotfiles
```

If you already cloned without submodules:

```bash
git submodule update --init --recursive
```

This repo does not currently ship with a bootstrap script or a `stow` setup, so the safe way to use it is to review the files you want and symlink them manually.

Example:

```bash
ln -s ~/dotfiles/.config/fish ~/.config/fish
ln -s ~/dotfiles/.config/ghostty ~/.config/ghostty
ln -s ~/dotfiles/.config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dotfiles/.config/git ~/.config/git
ln -s ~/dotfiles/.config/yazi ~/.config/yazi
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local
ln -s ~/dotfiles/.wezterm.lua ~/.wezterm.lua
```

Back up your existing configs first if you already use any of these tools.

## Fish setup

Fish is the main shell in this repo.

After installing it:

```bash
chsh -s $(which fish)
```

The Fish config expects or references tools such as:

- `starship`
- `atuin`
- `bun`
- `nvm`
- `go`
- Homebrew/Linuxbrew

There are also a few machine-specific paths in the current config, so review `~/.config/fish/config.fish` before using it as-is.

## Neovim

Neovim lives in `.config/nvim/` and is tracked as a git submodule:

```bash
git submodule update --init --recursive
```

If you want the full setup, make sure the language/runtime tools your Neovim config depends on are installed too.

## Fonts

This setup assumes JetBrains Mono Nerd Font.

I use it across terminal and editor configs, so install a Nerd Font first if icons or prompt symbols look wrong.

## Local and private config

Some parts of this repo are intentionally personal and should be reviewed before reuse:

- hardcoded `/home/samarth/...` paths
- Homebrew path assumptions under `/home/linuxbrew/.linuxbrew`
- GNOME `gsettings` changes in shell startup
- local env files such as `/home/samarth/.deno/env` and `$HOME/.turso/env`
- personal Git identity in `.config/git/config`

If you adapt this repo, keep secrets, machine-local paths, and personal identity settings in untracked local files.

## Optional tools

Other tools I use in this repo:

- `ghostty`
- `alacritty`
- `wezterm`
- `lazydocker`
- `redis`
- browser and CSS snippets under `env-configs/`

## Updating

Update the repo and its submodules with:

```bash
git pull
git submodule update --init --recursive
```

Then restart Fish, tmux, or your terminal apps as needed.

## Notes

- This repo is meant first for my own machines
- it should still be useful as reference or a starting point
- fork it, trim it, and make it yours instead of copying it blindly

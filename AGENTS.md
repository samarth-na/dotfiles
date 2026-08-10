# AGENTS.md

This repo is symlinked into `$HOME` with GNU Stow. The source of truth lives in
this repo. Edit files in place here. Do not edit the copies under `~/.config`,
`~/.tmux.conf`, or `~/.wezterm.lua`.

## Scope

This is a personal dotfiles repo. The configs are already symlinked into the
home directory, so you do not need to re-run Stow. Edit files here and the
changes take effect through the existing symlinks.

## Directories

Treat each directory as its own project. Edit configs in place and avoid
cross-contaminating.

- `.config/fish/` — primary shell config. It is split across `config.fish`,
  `etc.config.fish`, `paths.fish`, `conf.d/`, and `scripts/`.
- `.config/opencode/` — opencode config, agents, commands, and MCP servers. It
  has its own `AGENTS.md`.
- `.config/git/`, `.config/starship.toml`, `.tmux.conf`, `.tmux.conf.local`,
  `.wezterm.lua`, `.config/ghostty/`, `.config/alacritty/`, `.config/atuin/`,
  `.config/yazi/`, `.config/lazygit/`, `.config/lazydocker/` — secondary tool
  configs.
- `.github/`, `docs/`, `env-configs/`, `.zsh/` — workflows, notes, and shared
  editor tooling.

Neovim is not checked in as a git submodule. `.gitmodules` is empty. Confirm
with the user before assuming the submodule exists.

## Gotchas

- `config.fish` contains machine-specific paths: `/home/samarth`,
  `/home/linuxbrew/.linuxbrew`, `/opt/nvim`, `~/.deno/env`, `$HOME/.turso/env`,
  `~/.opencode/bin`, `~/.lmstudio/bin`.
- `config.fish` runs `gsettings set org.gnome.desktop.input-sources xkb-options
  "['ctrl:nocaps']"` on startup. This is GNOME-specific and is a no-op on other
  desktops.
- Fish PATH setup is split across `config.fish`, `etc.config.fish`,
  `paths.fish`, and `conf.d/*.fish`. Check all of them before you change PATH
  behavior.
- `conf.d/secrets.fish` exists but is gitignored. Never read its contents into
  a prompt or commit it.
- This repo expects a Nerd Font, especially JetBrains Mono Nerd Font, for
  prompt icons and terminal glyphs.
- `.tmux.conf` is the upstream Pakosz base config. Do not edit it. Override it
  in `.tmux.conf.local`.

## Working in this repo

- Use the `@explore` and `@search` subagents to read the codebase and research
  the web. They can run in parallel for lightweight tasks.
- The `@general` agent works well for multi-step work across configs.
- The `ste-plain-writing` skill applies plain-language rules to technical
  prose. Use it for writing that goes into docs or commit messages.
- The `browser-control` skill drives the visible browser when you need to test
  or inspect something.

## Verification

There is no repo-wide build or test harness. Verify changes by loading the
affected config directly:

- Fish: `fish -c "source <file>; echo ok"` or restart the shell.
- opencode: reload the config; JSONC must stay valid.
- Starship, yazi, terminals: run `starship config`, `yazi`, or restart the app.

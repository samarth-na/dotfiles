# AGENTS.md

## Scope

This is a personal dotfiles repo set up with GNU Stow. Configs were symlinked into `$HOME` via `stow` once at setup time — you do not need to re-run it. Edit files in place here; the existing symlinks point back to this repo.

## Important directories

Each directory below is effectively its own project; edit configs in place without cross-contaminating.

- `.config/fish/` — primary shell config (see Gotchas for the split across `config.fish`, `etc.config.fish`, `paths.fish`, `conf.d/`, `scripts/`).
- `.config/opencode/` — opencode editor config, custom agents/commands, MCP servers (own `AGENTS.md`).
- `.config/git/`, `.config/starship.toml`, `.tmux.conf`, `.tmux.conf.local`, `.wezterm.lua`, `.config/ghostty/`, `.config/alacritty/`, `.config/atuin/`, `.config/yazi/`, `.config/lazygit/`, `.config/lazydocker/` — secondary tool configs.
- `.github/`, `docs/`, `env-configs/` — workflows, notes, and shared editor tooling configs.

Note: `README.md` references `.config/nvim/` as a git submodule, but it is not currently checked in here and `.gitmodules` is empty. If Neovim work is needed, confirm with the user before assuming the submodule exists.

## Subagents

Use the `@explore` and `@search` subagents for reading and web research; they can be run in parallel for lightweight tasks. Prefer them over rummaging through large trees directly.

## Gotchas

- `config.fish` contains machine-specific paths and assumptions: `/home/samarth`, `/home/linuxbrew/.linuxbrew`, `/opt/nvim`, `~/.deno/env`, `$HOME/.turso/env`, `~/.opencode/bin`, `~/.lmstudio/bin`.
- `config.fish` runs `gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"` on startup (GNOME-specific; no-op on other DEs).
- Fish PATH setup is split across `config.fish`, `etc.config.fish`, `paths.fish`, and `conf.d/*.fish`; check all of them before changing PATH behavior.
- `conf.d/secrets.fish` exists but is gitignored — never read its contents into prompts or commit it.
- This repo expects a Nerd Font (JetBrains Mono Nerd Font) for prompt icons and terminal glyphs (ghostty, alacritty, wezterm all assume it).

## Verification

There is no repo-wide build or test harness. Verify changes by loading the affected config directly:
- Fish: `fish -c "source <file>; echo ok"` or restart the shell.
- opencode: reload via `opencode` config; JSONC must stay valid.
- Starship/Yazi/terminals: `starship config`, `yazi`, or restart the app.

## Mapping to `.config`

This repo is symlinked into the home directory, so read `.config/` here first rather than `~/.config/`. For `opencode/`, `fish/`, and any config present in this repo, the contents are identical. Only fall back to `~/.config/` if a file you need is not in this repo.
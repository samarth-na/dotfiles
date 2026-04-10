# AGENTS.md

## Scope
- This is a personal dotfiles repo, not a bootstrap or `stow` setup.
- Review files first and symlink only the configs you intend to use.

## Layout
- `.config/fish/` is the main shell config; `config.fish` sources `scripts/non-interactive.fish`, `scripts/alias.fish`, `vim.fish`, and interactive-only helpers under `scripts/` and `completions/`.
- `scripts/non-interactive.fish` defines `changeTmuxPane` and the `run` helper; `scripts/functions.fish` defines `mdc` and `te`.
- `.config/opencode/` is its own npm package/config area; keep `package.json` and `package-lock.json` aligned when changing it.
- `.config/nvim/` is a git submodule.

## Gotchas
- `config.fish` has machine-specific paths and assumptions: `/home/samarth`, `/home/linuxbrew/.linuxbrew`, `/opt/nvim`, `~/.deno/env`, and `$HOME/.turso/env`.
- `config.fish` also runs `gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"` on shell startup.
- Fish path setup is split between `config.fish`, `etc.config.fish`, and `paths.fish`; check all three before editing PATH behavior.
- This repo expects a Nerd Font, especially JetBrains Mono Nerd Font, for prompt and terminal icons.

## Verification
- There is no repo-wide build/test harness in the root docs; verify changes by loading the affected shell or app config directly.
- For Neovim changes, update the submodule separately if needed.

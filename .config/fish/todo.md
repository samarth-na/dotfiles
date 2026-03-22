# Fish Config Cleanup

## Dead Files
- [ ] Delete `paths.fish` (commented out in config.fish:42)
- [ ] Delete `prompt.fish` (entirely commented out, unused)
- [ ] Delete `functions/fish_prompt.fish` (starship replaces it in etc.config.fish)
- [ ] Delete `*.tmp` files (kyc89yjf6l.tmp, n2yvuhpcy3.tmp, sw04iof23b.tmp)

## PATH Fixes
- [ ] Replace all `set -gx PATH $PATH ...` with `fish_add_path` in config.fish
- [ ] Move `BUN_INSTALL` definition before its PATH usage (config.fish:21 before config.fish:19)
- [ ] Remove `conf.d/rustup.fish` (redundant — cargo/bin already in PATH via etc.config.fish)

## Startup Performance
- [ ] Guard `gsettings` call in config.fish:46 so it runs once (use a universal variable check)
- [ ] Guard `homebrew.fish` completions to avoid spawning `brew` unnecessarily
- [ ] Remove manual sourcing of `completions/homebrew.fish` in config.fish:50 (fish auto-loads completions/)

## Structural Cleanup
- [ ] Remove empty `else` block in config.fish:56-58
- [ ] Remove duplicate `\ck` binding in commands.fish:7 (overridden by config.fish:53)
- [ ] Clarify `etc.config.fish` — either merge into `config.fish` or move to `/etc/fish/config.fish`

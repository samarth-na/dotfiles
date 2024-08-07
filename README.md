# dependencies

1. nvim
2. wezterm
3. tmux
4. zsh
5. yazi
6. btop
7. lazygit
8. lazydocker
9. fzf
10. bat
11. starship
12. htop
13. bun
14. vlc
15. zoxide
16. eza

for nvim

```bash
sudo dnf install neovim cmake gcc-c++ libtool libuv libvterm msgpack-devel unibilium gettext-devel lua-devel

```

other available on dnf

```bash
sudo dnf install  btop lazygit lazydocker eza fzf bat htop tmux vlc zoxide
```

```bash
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
```

some package managers

```bash
curl -fsSL https://bun.sh/install | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

for yazi

```bash
sudo dnf install ffmpegthumbnailer p7zip p7zip-plugins jq poppler-utils fd-find ripgrep fzf zoxide ImageMagick xclip xsel wl-clipboard
```

```bash
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
```

for starship

```bash
dnf install starship
```

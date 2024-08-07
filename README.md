# main apps

-   nvim
-   wezterm
-   tmux
-   zsh

# other apps

-   yazi
-   btop
-   lazygit
-   lazydocker
-   fzf

# tools

-   starship
-   htop
-   bun
-   zoxide
-   eza
-   bat
-   procs
-   gdu
-   mpv
-   vlc

## for nvim

```bash
sudo dnf install neovim cmake gcc-c++ libtool libuv libvterm msgpack-devel unibilium gettext-devel lua-devel
```

## other available on dnf

```bash
sudo dnf install  btop lazygit lazydocker eza fzf bat htop tmux vlc zoxide
```

## for zsh and ohmyzsh

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

## for yazi

### the dependencies

```bash
sudo dnf install ffmpegthumbnailer p7zip p7zip-plugins jq poppler-utils fd-find ripgrep fzf zoxide ImageMagick xclip xsel wl-clipboard
```

### yazi install from cargo

```bash
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
```

## for starship

```bash
dnf install starship
```

first update all packages

```bash
sudo dnf update
```

# main apps

-   neovim - terminal code editor
-   wezterm - terminal emulator
-   tmux - terminal multiplexer
-   zsh - shell

## other apps

-   yazi powerful file manager
-   btop - system monitor
-   lazygit - git client
-   lazydocker - docker client
-   fzf - fuzzy finder

## tools

-   starship - status line prompt
-   htop - system monitor
-   zoxide - better cd alternative
-   eza - better ls alternative
-   bat - better cat alternative
-   procs - better ps alternative
-   mpv - terminal audio player
-   vlc - video player

---

### neovim installation

-   dependencies -

```bash
sudo dnf install  cmake gcc-c++ libtool libuv libvterm msgpack-devel unibilium gettext-devel lua-devel
```

-   install nvim -

```bash
sudo dnf neovim
```

### install zsh and set it as default shell

-   installation

```bash
sudo dnf install zsh
# check the installation
zsh --version
which zsh
```

-   install oh-my-zsh package manager

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

-   set zsh as default shell

```bash
chsh -s $(which zsh)
```

### install tmux

```bash
sudo dnf install tmux
```

basic setup is complete time to install other apps and tools

### other available apps on dnf

```bash
sudo dnf install  starship btop lazygit lazydocker eza fzf bat htop vlc zoxide mpv
```

---

# some package managers

## javascript package manager

---

### bun install

```bash
curl -fsSL https://bun.sh/installation | bash # for macOS, Linux, and WSL
```

### npm/node install

```bash
sudo dnf install  nodejs npm
```

### pnpm install

```bash
npm installation -g pnpm
```

### nvm install

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
```

---

## rust

-   rustup/cargo installation

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## linuxbrew

-   install build tools

```bash

sudo yum install procps-ng
curl file git
```

-   install linuxbrew

```bash
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
```

```bash
# test the installation
brew install hello
```

## golang

```bash
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.6.linux-amd64.tar.gz
```

---

## yazi

-   the dependencies

```bash
sudo dnf install  ffmpegthumbnailer p7zip p7zip-plugins jq poppler-utils fd-find ripgrep fzf zoxide ImageMagick xclip xsel wl-clipboard
```

-   yazi installation from cargo

```bash
cargo installation --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
```

#### repository for all my dotfiles, End all be all for all my linux system and app configurations

> ### first update all packages
>
> ```bash
> sudo dnf update
> ```

## main applications

- **neovim** - fast/cli/modal code editor (dnf)
- **alacritty** - fast/beautiful terminal emulator (flatpak)
- **tmux** - powerful/peristing terminal multiplexer (dnd)
- **zsh** - modern shell with plugin support (dnf)

### other apps

- **yazi** - amazing file manager (linuxbrew/cargo)
- **btop** - beautiful system monitor (dnf)
- **lazygit** - tui git client (dnf)
- **zoxide** - better cd alternative (dnf)

### tools

- **fzf** - fuzzy finder utility (dnf)
- **atuin** - shell history manager/search (linuxbrew)
- **starship** - status line prompt (dnf)
- **eza** - better ls alternative (dnf)
- **vlc** - video player (flatpack)
- **mpv** - terminal audio player (dnf)
- **htop** - system monitor (dnf)
- **procs** - better ps alternative (dnf)
- **gdu** - disk usage analyzer (dnf)
- **bat** - better cat alternative (dnf)
- **ripgrep** - better grep alternative (dnf)
- **fd** - better find alternative (dnf)
- **hyperfine** - benchmarking tool (dnf)
- **duf** - better df alternative (dnf)
- **dust** - better du alternative (linuxbrew)
- **tabiew** - viewer for csv and tsv files (linuxbrew)
- **dua** - disk usage analyzer (linuxbrew)
- **topgrade** - upgrade all packages (linuxbrew)
- **age** - file encryption tool (dnf)

### fonts

##### jetbrains mono nerd font

- semi bold for interface and window titles
- regular for documents and code

---

### neovim

- dependencies -

```bash
sudo dnf install  cmake gcc-c++ libtool libuv libvterm msgpack-devel unibilium gettext-devel lua-devel
```

- install the package -

```bash
sudo dnf neovim
```

### install zsh and set it as default shell

- installation

```bash
sudo dnf install zsh
# check the installation and source
zsh --version
which zsh
```

- install oh-my-zsh package manager of my choice

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- set zsh as default shell

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
sudo dnf install  btop lazygit fzf zoxide eza mpv htop procs gdu bat fd hyperfine
```

---

## linuxbrew

- install build tools

```bash
sudo dnf groupinstall "Development Tools"
sudo dnf install curl file git
```

- install linuxbrew from source

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- test linuxbrew installation

```bash
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew --version
# test the installation
brew install hello
```

Ensure Homebrew is up-to-date:

```bash
brew update
brew upgrade
```

> ##### linuxbrew is an fork of Homebrew, the package manager for macOS. this lets us install all apps we macos have but dnf doesnt

packages available on linuxbrew

```bash
brew install tabiew duf dua atuin topgrade
```

---

# important package managers/languages

## JS/TS package managers

### bun

```bash
curl -fsSL https://bun.sh/install | bash # for macOS, Linux, and WSL
```

### npm & node

```bash
sudo dnf install  nodejs npm
```

### pnpm install

```bash
sudo npm i -g pnpm
```

### nvm install

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
```

---

## rust

- rustup/cargo installation

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## golang

```bash
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.6.linux-amd64.tar.gz
```

## c++

```bash
sudo dnf install g++ gcc-c++
```

## python3/pip

```bash
sudo dnf install python3-pip
```

---

## yazi

- the dependencies

```bash
sudo dnf install ffmpegthumbnailer p7zip p7zip-plugins jq poppler-utils fd-find ripgrep fzf zoxide ImageMagick xclip xsel wl-clipboard
```

- yazi installation from cargo _(you need to have rust installed)_

```bash
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
```

- yazi installation with linuxbrew

```bash
brew install yazi
```

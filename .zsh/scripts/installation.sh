#!/bin/bash

# Exit script on any error
set -e

echo "Updating system..."
sudo dnf update -y

# Install dependencies
echo "Installing dependencies..."
sudo dnf group install -y "Development Tools"
sudo dnf install -y curl file git gcc make bzip2 zsh neovim

# Install Linuxbrew (Homebrew for Linux)
echo "Installing Linuxbrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Linuxbrew to PATH
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
fi

# Install Zoxide via Homebrew
echo "Installing Zoxide..."
brew install zoxide

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Change default shell to Zsh
echo "Changing default shell to Zsh..."
chsh -s $(which zsh)

# Configure Zoxide plugin in Zsh
if ! grep -q "zoxide" ~/.zshrc; then
  echo 'eval "$(zoxide init zsh)"' >>~/.zshrc
fi

# Install Neovim (if not installed via Homebrew)
echo "Verifying Neovim installation..."
if ! command -v nvim &>/dev/null; then
  brew install neovim
fi

echo "Installation complete! Please restart your terminal."

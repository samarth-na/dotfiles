# user fish config there is also some changes in /etc/fish/config.fish

# global PATH setup
# set -gx PATH $PATH /usr/bin
# set -gx PATH $PATH /usr/sbin
# set -gx PATH $PATH /usr/local/bin

# local PATHS
set -gx PATH $PATH $HOME/bin \ $HOME/.local/bin
set -gx GOPATH $HOME/go \ $HOME/go/bin \ /usr/local/go/bin
# set -gx PATH $PATH $HOME/.cargo/bin 

# javascript PATHS
set -gx PATH $PATH $BUN_INSTALL/bin
set -gx PATH $PATH ~/.deno/bin 
set -gx BUN_INSTALL "$HOME/.bun"
set -gx NVM_DIR "$HOME/.nvm"
set -gx PNPM_HOME "/home/samarth/.local/share/pnpm"

# Linuxbrew
set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH

# Other env vars
set -gx ZSH $HOME/.oh-my-zsh
set -gx PATH $PATH /opt/nvim/
set -gx OPENSSL_CONF ""
# set -gx MANPATH /usr/share/man 
# set -gx ARCHFLAGS "-arch x86_64"
# set -gx LANG "en_US.UTF-8"
# set -gx EDITOR "nvim"
# set -gx VISUAL "nvim"

source ~/.config/fish/scripts/non-interactive.fish


if status is-interactive

    gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"

    source ~/.config/fish/scripts/alias.fish
    source ~/.config/fish/scripts/functions.fish
    source ~/.config/fish/scripts/commands.fish
    source ~/.config/fish/completions/homebrew.fish

    bind \ck _atuin_search
end



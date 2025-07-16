# Put system-wide fish configuration entries here
# or in .fish files in conf.d/
# Files in conf.d can be overridden by the user
# by files with the same name in $XDG_CONFIG_HOME/fish/conf.d
# This file is run by all fish instances.
# To include configuration only for login shells, use


# Basic system PATH setup (safe for all users)
set -gx PATH $PATH /usr/bin
set -gx PATH $PATH /usr/sbin
set -gx PATH $PATH /usr/local/bin

# Standard manpath
set -gx MANPATH /usr/share/man

# Common language settings
set -gx LANG "en_US.UTF-8"
set -gx ARCHFLAGS "-arch x86_64"

# Default editor (vim/nvim is common for servers)
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# cargo path
set -gx PATH $PATH /home/samarth/.cargo/bin



# function fish_greeting
#      uptime
# end


# To include configuration only for interactive shells, use
if status is-interactive

    starship init fish | source
    zoxide init fish | source
    zoxide init --cmd cd fish | source

    atuin init fish | source
    set -gx ATUIN_NOBIND "true"
end

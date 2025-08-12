alias c='clear'

# apps 

alias e nvim

alias fm yazi
alias y yazi
alias b btop
alias ld lazydocker
alias lg lazygit
alias oma ollama
alias ff fastfetch

alias E='sudo nvim'
alias kn='killall nvim '
alias obs="cd ~/obsidian/ && nvim "

# systemctl
alias stl='systemctl'

# git
# https://x.com/melqtx/status/1952632895014625606

# dnf
alias sdi='sudo dnf install'
alias sdr='sudo dnf remove'
alias upd='sudo dnf update'
alias ref='sudo dnf upgrade --refresh'
alias upg='sudo dnf upgrade '

# tmux
alias ta='tmux attach-session'
alias ttop='tmux set -g status-position top'
alias tbot='tmux set -g status-position bottom'
alias tg="tmux popup -w 100% -h 100% -d $(pwd) -E lazygit"

# eza
alias lt2='eza --tree --icons --level=3 --icons -a  -lBb '
alias lt3='eza --tree --icons --level=4 --icons -a  -lBb '
alias lt='eza --tree --icons --level=2 --icons -a   -lBb '
alias l='eza --icons'
alias la='eza --icons -a'
alias L='eza --icons -lahBb --git '

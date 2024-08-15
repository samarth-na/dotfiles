#-----------------------commands---------------------------
alias info='info --vi-key'

#--------------------nvim----------------------------------

alias v='nvim'
alias e='nvim'
alias e.='nvim .'
alias kn='killall nvim '



alias so='source ~/.zshrc'
#-----------------------------clear--------------------------

alias c='clear'
alias cl='clear'
alias cls='clear'

#--------------------------apps------------------------------
alias fm='yazi'
alias y='yazi'
alias b='btop'

#------------------------dnf---------------------------------
alias sdi='sudo dnf install'
alias upd='sudo dnf update'
alias ref='sudo dnf upgrade --refresh'
alias upg='sudo dnf upgrade '

#------------------------eza---------------------------------
alias lt2='eza --tree --icons --level=3 --icons -a  -lBb '
alias lt3='eza --tree --icons --level=4 --icons -a  -lBb '
alias lt='eza --tree --icons --level=2 --icons -a   -lBb '
alias l='eza --icons'
alias la='eza --icons -a'
alias L='eza --icons -lahBb --git '

#--------------------------tmux------------------------------

alias t='tmux'
alias ta='tmux attach-session'

alias ttop='tmux set -g status-position top'
alias tbot='tmux set -g status-position bottom'

#-------------------------liveserverhost-----------------------------
alias host='bun run dev'
alias livehost='bun run dev -- -H 192.168.1.8'
alias zshs='source ~/.zshrc'

#-------------------runners--------------------------
alias gp='g++'
alias pp='g++'
alias g.='go run .'
alias py='python'
alias cct= 'codecrafters test'
#-------------------web-search------------
alias pd="web_search phind "
alias px="web_search px"
alias gpt="web_search gpt "
alias stack="stackoverflow"
#-----------------------------scripts-------------------------
alias mdc='mcd() { mkdir "$@" && cd "$@" }; mcd'

#---------------------------navigation-----------------------------
alias obs="cd ~/obsidian/ && nvim "




alias editfileinneovim='fd --type f --max-depth=1 | fzf  --reverse | xargs -o nvim'


alias play='find ~/Music -type f \( -name "*.mp3" -or -name "*.m4a" -or -name "*.webm" \)| fzf-tmux --reverse -p |xargs -I {} vlc "{}"
'
alias ChangeTmuxPane="
 tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}.#{window_name}-#{pane_current_path}' | fzf-tmux -p | cut -d "." -f 1 |xargs tmux switch-client -t
 "
alias ct='
tmux list-windows -a -F "#S:#I-#W" | fzf-tmux -p | cut -d "-" -f 1 | xargs tmux switch-client -t
'


# fdd() {
#   cd $(fd -H --type=d "$@" |fzf --preview " eza -laBb  --no-permissions --no-time --no-user {}")
# };

# fdz() {
#   fd -H --type=d "$!" | fzf --preview "eza -laBb  --no-permissions --no-time --no-user {}"
# }

fld() {
    cd $(fd -H --type=d "$1" | fzf --preview "eza -labB {}")

}

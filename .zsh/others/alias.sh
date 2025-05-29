#-----------------------utils---------------------------


alias c='clear'
alias cl='clear'
alias cls='clear'
#--------------------nvim----------------------------------

alias v='nvim'
alias N='sudo nvim'
alias e='nvim'
alias e.='nvim .'
alias kn='killall nvim '



#--------------------------apps------------------------------
alias fm='yazi'
alias y='yazi'
alias b='btop'
alias ld='lazydocker'
alias g='git'
alias oma='ollama'
alias lg='lazygit'
alias obs="cd ~/obsidian/ && nvim "

#------------------------dnf---------------------------------
alias sdi='sudo dnf install'
alias sdr='sudo dnf remove'
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

alias ta='tmux attach-session'

alias ttop='tmux set -g status-position top'
alias tbot='tmux set -g status-position bottom'
alias tg="tmux popup -w 100% -h 100% -d $(pwd) -E lazygit"


#-------------------------liveserverhost-----------------------------
alias vcreate= 'bun create vite@latest'
# alias host='bun run dev'
# alias livehost='bun run dev -- -H 192.168.1.8'
alias zshs='source ~/.zshrc'

#-------------------runners--------------------------
alias gp='g++'
alias pp='g++'
alias g.='go run .'
alias py='python'
alias run='run.sh'
alias so='source ~/.zshrc'
alias cct= 'codecrafters test'

#-------------------web-search------------
alias pd="web_search phind "
alias px="web_search px"
alias gpt="web_search gpt "
alias stack="stackoverflow"

#-----------------------------mk and cd-------------------------
function mdc(){
    mkdir "$@" 
    cd "$@" || cd ..
}


#-----------------------------big stuff-------------------------

alias editfileinneovim='fd --type f --max-depth=1 | fzf  --reverse | xargs -o nvim'

alias play='find ~/Music -type f \( -name "*.mp3" -or -name "*.m4a" -or -name "*.webm" \)| fzf-tmux --reverse -p |xargs -I {} mpv "{}"
'
alias ChangeTmuxPane="
 tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}.#{window_name}-#{pane_current_path}' | fzf-tmux -p | cut -d "." -f 1 |xargs tmux switch-client -t
 "
alias ct='
tmux list-windows -a -F "#S:#I-#W" | fzf-tmux -p | cut -d "-" -f 1 | xargs tmux switch-client -t
'



fld() {
    cd $(fd -H --type=d "$1" | fzf --preview "eza -labB {}")

}

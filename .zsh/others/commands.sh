function my_command() {
    Enewtmux
}
zle -N my_command
bindkey '^[E' my_command

function OpenFileInNvim() {
    editfileinneovim
}
zle -N OpenFileInNvim
bindkey '^[e' OpenFileInNvim

function tmuxswitch() {
    openDirInNewTmuxWindow
};
zle -N tmuxswitch
bindkey '^[d' tmuxswitch
function paneswitch() {
    changeTmuxPane
};
zle -N paneswitch 
bindkey '^[t' paneswitch


pop()
{
    tmux popup
};
zle -N pop
bindkey '^\' pop

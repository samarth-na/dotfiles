
function ChangeTmuxPane() {
    ChangeTmuxPane
};
zle -N ChangeTmuxPane 
bindkey '^[t' ChangeTmuxPane



function zoxide-cmd() {
   zi 
};
zle -N zoxide-cmd 
bindkey '^[d' zoxide-cmd 

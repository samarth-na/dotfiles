
function ChangeTmuxPanecmd() {
    ChangeTmuxPane
};
zle -N ChangeTmuxPanecmd
bindkey '^[t' ChangeTmuxPanecmd



function zoxide-cmd() {
   zi
};
zle -N zoxide-cmd
bindkey '^[d' zoxide-cmd


# function open_man_page() {
#     local cmd
#         cmd=$(echo "$BUFFER" | awk '{print $1}')  # Extract the first word (command)
#     if command -v "$cmd" > /dev/null 2>&1; then
#         man "$cmd"
#     else
#         echo "Command '$cmd' not found."
#     fi
#     zle reset-prompt  # Reset the prompt
# }
#
# # Bind Ctrl+M to the function
# zle -N open_man_page
# bindkey '^M' open_man_page

# ~/.config/fish/config.fish

# Enable vi mode
set -g fish_key_bindings fish_vi_key_bindings

# Clipboard integration
function fish_user_key_bindings
    # Copy current command line (yy)
    bind -M default yy 'commandline | wl-copy; '
    
    # Paste from clipboard (p)
    bind -M default p 'commandline -i (wl-paste)'
    
    # Paste before cursor (P)
    bind -M default P 'commandline -i -- (wl-paste)'
    
    # In visual mode, copy selection to clipboard
    bind -M visual y 'commandline -f end-selection; commandline | wl-copy; '
    
    # In visual mode, cut selection
    bind -M visual x 'commandline -f end-selection; commandline -f kill-selection; commandline | wl-copy'
end

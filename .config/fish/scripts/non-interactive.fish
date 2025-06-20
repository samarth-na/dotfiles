function changeTmuxPane --description 'Change tmux pane with fuzzy selection'
    # Check if inside tmux
    if not set -q TMUX
        echo "Error: Not in a tmux session" >&2
        return 1
    end

    # Get selection from fzf
    set -l target (tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}.#{window_name}-#{pane_current_path}' \
        | fzf-tmux -p \
        | cut -d "." -f 1)

    # Only switch if we got a selection
    if test -n "$target"
        tmux switch-client -t "$target" 2>/dev/null
        or echo "" >&2
    end
end


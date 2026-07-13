#!/usr/bin/env bash
# Change tmux pane with fuzzy selection (bash equivalent)

if [[ -z "${TMUX:-}" ]]; then
    echo "Error: Not in a tmux session" >&2
    exit 1
fi

target=$(tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}.#{window_name}-#{pane_current_path}' \
    | fzf-tmux -p \
    | cut -d "." -f 1)

if [[ -n "$target" ]]; then
    tmux switch-client -t "$target" 2>/dev/null || true
fi

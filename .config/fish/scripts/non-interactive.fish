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

function run --description 'Find the latest file modified in the ~/codes and
    run it'
    set -l path = (fd --type f -0 . ~/codes | xargs -0 stat --format='%Y %n' 2>/dev/null | sort -nr | head -1 | awk '{print $2}')

    
    if test -n "$path"
        set -l filename (basename "$path")
        set -l extension (string split -r -m1 . -- "$filename")[-1]

        if test "$filename" = "$extension"
            set extension ""
        end


        switch $extension
            case 'c' 'c++' 'cpp'
                g++ "$path"
            case 'out'
                ./a.out
            case 'java'
                java "$path"
            case 'go'
                go run "$path"
            case 'lua'
                lua "$path"
            case 'py'
                python "$path"
            case 'js'
                node "$path"
            case 'ts'
                deno "$path"
            case 'rs'
                rustc "$path" && ./"$filename"
            case 'sh'
                sh "$path"
            case 'fish'
                fish "$path"
            case '*'
                echo "No handler for extension: $extension"
        end

        echo "$path"
    else
        echo "no file found"
    end

end

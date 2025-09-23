function mdc --description 'Make directory and cd into it'
    if test (count $argv) -eq 0
        echo "Usage: mdc <directory>"
        return 1
    end

    mkdir -p $argv
    and cd $argv[1]
    or begin
        echo "Failed to create or enter directory" >&2
        return 1
    end
end


function te --description 'create a file and open it in $EDITOR'
    touch $argv
    and nvim $argv
    or echo "Failed to create file" >&2
end

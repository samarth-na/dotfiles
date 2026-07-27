function bkill
    set -l pids (pgrep -f browser-control-mcp)
    if test -n "$pids"
        kill $pids 2>/dev/null
        echo "Killed browser-control-mcp (PIDs: $pids)"
    else
        echo "No browser-control-mcp processes running"
    end

    sed -i '/"browser-control"/,/"enabled"/ s/"enabled": true/"enabled": false/' \
        $HOME/.config/opencode/opencode.jsonc

    echo "browser-control disabled in config"
end

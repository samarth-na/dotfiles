function bon
    set -l cfg $HOME/.config/opencode/opencode.jsonc
    sed -i '/"browser-control"/,/"enabled"/ s/"enabled": false/"enabled": true/' \
        $cfg

    echo "browser-control enabled in config"

    # Runtime connect so it works now, not only on next session.
    # Config alone leaves the running service in failed: Connection closed.
    if command -q opencode
        opencode api post "/api/mcp/browser-control/connect?location[directory]=$PWD" 2>/dev/null
        if test $status -eq 0
            echo "browser-control connected for $PWD"
        else
            echo "connect call failed (starts on next opencode session)"
        end
    end
end

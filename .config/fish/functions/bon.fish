function bon
    set -l cfg $HOME/.config/opencode/opencode.jsonc
    sed -i '/"browser-control"/,/"disabled"/ s/"disabled": true/"disabled": false/' \
        $cfg

    echo "browser-control enabled in config"

    # Runtime connect so it works now, not only on next session.
    # The connect call overrides a disabled configuration until restart.
    if command -q opencode
        opencode api post "/api/experimental/mcp/browser-control/connect?location[directory]=$PWD" 2>/dev/null
        if test $status -eq 0
            echo "browser-control connected for $PWD"
        else
            echo "connect call failed (starts on next opencode session)"
        end
    end
end

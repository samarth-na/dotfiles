function bkill
    # Clean disconnect first so the server drops the tools
    # instead of keeping a stale failed: Connection closed entry.
    if command -q opencode
        opencode api post "/api/experimental/mcp/browser-control/disconnect?location[directory]=$PWD" 2>/dev/null
    end

    # Stop the MCP stdio server(s). OpenCode starts one per session/location,
    # so several may be running at once.
    set -l mcp_pids (pgrep -f "[b]rowser-control-mcp")
    if test -n "$mcp_pids"
        kill $mcp_pids 2>/dev/null
        echo "Stopped browser-control MCP (PIDs: $mcp_pids)"
    else
        echo "No browser-control MCP processes running"
    end

    # Stop the managed relay that browser-control keeps running on port 19989.
    # 0.8+ runs the relay as a separate "cli.js serve" process that outlives the
    # MCP server; SIGTERM drains it gracefully and it restarts on next use.
    set -l relay_pids (pgrep -f "[b]rowser-control serve|[c]li.js serve")
    if test -n "$relay_pids"
        kill $relay_pids 2>/dev/null
        echo "Stopped Browser Control relay (PIDs: $relay_pids)"
    else
        echo "No Browser Control relay running"
    end

    sed -i '/"browser-control"/,/"disabled"/ s/"disabled": false/"disabled": true/' \
        $HOME/.config/opencode/opencode.jsonc

    echo "browser-control disabled in config"
end

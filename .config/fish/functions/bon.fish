function bon
    sed -i '/"browser-control"/,/"enabled"/ s/"enabled": false/"enabled": true/' \
        $HOME/.config/opencode/opencode.jsonc

    echo "browser-control enabled in config (will start on next opencode session)"
end

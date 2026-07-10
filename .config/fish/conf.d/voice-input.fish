if test -f /usr/lib64/libclang.so
    set -gx LIBCLANG_PATH /usr/lib64
end

if test -d /usr/lib64/alsa-lib
    set -gx ALSA_PLUGIN_DIR /usr/lib64/alsa-lib
end

fish_add_path -p $HOME/.local/bin

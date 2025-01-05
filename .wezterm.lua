local wezterm = require("wezterm")

local config = {
    color_scheme = "One Dark (Gogh)",
    -- color_scheme = 'Tokyo Night Moon',

    window_background_opacity = 0.90,
    window_decorations = "NONE",
    hide_tab_bar_if_only_one_tab = true,
    font_size = 20,
    line_height = 1.0,
    -- initial_rows = 42,
    -- initial_cols = 144,
    window_padding = { left = 0, right = 0, top = 3, bottom = 0 },
    force_reverse_video_cursor = true,
    foreground_text_hsb = {
        hue = 1.0,
        saturation = 1.00,
        brightness = 1.00,
    },
    audible_bell = "Disabled",
}

-- config.colors = { foreground = "#abb2bf" }
-- config.font = wezterm.font("jetbrains Nerd Font")

config.window_background_image_hsb = {
    -- Darken the background image by reducing it to 1/3rd
    brightness = 1.2,

    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    hue = 1.0,

    -- You can adjust the saturation also.
    saturation = 1.0,
}

return config

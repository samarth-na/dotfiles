local wezterm = require("wezterm")

local config = {
	color_scheme = "One Dark (Gogh)",
	window_background_opacity = 0.96,
	window_decorations = "NONE",
	hide_tab_bar_if_only_one_tab = true,
	font_size = 21,
	line_height = 1.0,
	initial_rows = 42,
	initial_cols = 144,
	window_padding = { left = 0, right = 0, top = 2, bottom = 0 },
	force_reverse_video_cursor = true,
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.05,
		brightness = 1.05,
	},
	audible_bell = "Disabled",
}

config.colors = { foreground = "#abb2bf" }
-- config.font = wezterm.font("JetBrains Mono", { weight = "Regular", italic = false })

-- things below dont work
-- config.window_background_image = '~/marek-piwnicki-wgsu3WzFZ5c-unsplash.jpg'

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 1.3,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}

return config

local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font Mono")
config.color_scheme = "Tokyo Night"
config.font_size = 11.0
config.enable_tab_bar = false
config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 10
return config

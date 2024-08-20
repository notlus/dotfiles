local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85
config.default_cursor_style = "BlinkingBar"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.color_scheme = "Tokyo Night"
config.font_size = 11.0
config.enable_tab_bar = false
-- config.macos_window_background_blur = 10
return config

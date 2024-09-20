local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.leader = { key = "s", mods = "CTRL" }
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
config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },

	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },

	{ key = "v", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	{ key = "h", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

	-- Vim-like pane navigation
	{ key = "h", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
}
return config

-- Pull in the wezterm API
local wezterm = require("wezterm")
local sessionizer = require("sessionizer")

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.front_end = "OpenGL"

-- For example, changing the color scheme:
config.color_scheme = "rose-pine-moon"

config.font = wezterm.font({
	family = "JetBrains Mono",
	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 20.0

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- config.disable_default_key_bindings = true
-- -- Keybindings like tmux
-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.keys = {
-- 	-- sends C-a to the terminal
-- 	{
-- 		key = "a",
-- 		mods = "LEADER|CTRL",
-- 		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
-- 	},
-- 	-- splitting
-- 	{
-- 		mods = "LEADER",
-- 		key = "-",
-- 		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "=",
-- 		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
-- 	},
-- 	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
-- 	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
-- 	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
-- 	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
-- 	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
-- 	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 10 } }) },
-- 	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 10 } }) },
-- 	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 10 } }) },
-- 	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 10 } }) },
-- 	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
-- 	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
-- 	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
-- 	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
-- 	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
-- 	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
-- 	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
-- 	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
-- 	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
-- 	{ key = "1", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 0 }) },
-- 	{ key = "2", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 1 }) },
-- 	{ key = "3", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 2 }) },
-- 	{ key = "4", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 3 }) },
-- 	{ key = "5", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 4 }) },
-- 	{ key = "6", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 5 }) },
-- 	{ key = "7", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 6 }) },
-- 	{ key = "8", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 7 }) },
-- 	{ key = "9", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTab = 8 }) },
-- 	{ key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
-- 	{ key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
-- 	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
-- 	{ key = "f", mods = "LEADER", action = wezterm.action_callback(sessionizer.toggle) },
-- 	{ key = "(", mods = "LEADER", action = wezterm.action({ SwitchWorkspaceRelative = -1 }) },
-- 	{ key = ")", mods = "LEADER", action = wezterm.action({ SwitchWorkspaceRelative = 1 }) },
-- 	{ key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
-- 	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },
-- 	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
-- 	{ key = "V", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
-- 	{ key = "C", mods = "CTRL", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
-- }

-- and finally, return the configuration to wezterm
return config

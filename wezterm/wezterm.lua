-- Pull in the wezterm API
local wezterm = require("wezterm")
local utf8 = require("utf8")

-- this table will hold the configuration
local config = {}

-- This will hold the configuration.
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.automatically_reload_config = true
-- config.window_decorations = "TITLE | RESIZE"
config.default_cursor_style = "BlinkingBlock"
config.font = wezterm.font("Fira Code")
config.default_prog = { "pwsh.exe" }

config.color_scheme = "OneDark (base16)"
config.colors = {
	tab_bar = {
		background = "#282c34", -- Background of the entire tab bar (matches OnedarkPro background)

		active_tab = {
			bg_color = "#5fa9e6", -- A bright blue for the active tab background (matches OnedarkPro accents)
			fg_color = "#282c34", -- Dark text color for contrast
			italic = false, -- Optional: Customize text style
		},

		inactive_tab = {
			bg_color = "#3e4451", -- A muted gray for inactive tabs
			fg_color = "#abb2bf", -- Subtle text color for inactive tabs
		},

		inactive_tab_hover = {
			bg_color = "#4b5362", -- Slightly brighter gray when hovering over inactive tabs
			fg_color = "#d7dae0", -- Text color for hovered tabs
		},

		new_tab = {
			bg_color = "#3e4451", -- Same as inactive tabs
			fg_color = "#98c379", -- Green accent for the "new tab" button
		},

		new_tab_hover = {
			bg_color = "#4b5362", -- Hover background for the new tab button
			fg_color = "#d7dae0", -- Hover text color
		},
	},
}
config.window_background_opacity = 1.0 -- make the background transparent
config.max_fps = 240 -- increase the frame rate

-- tmux-like keybindings
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	-- creating and closing tabs
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- moving between tabs
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- splitting the window
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- navigating the window
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- resize with arrow keys
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
}

-- for loop to create keybindings for tabs
for i = 0, 9 do
	-- leader + number to activate tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- tmux status bar
wezterm.on("update-right-status", function(window, _)
	-- retrive specific colors from the active colo scheme
	local active_fg = "#3e4451" -- foreground color
	local active_bg = "#ad535a" -- background color
	local arrow_color = "#5fa9e6" -- cursor color

	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = active_fg } }
	local prefix = ""

	if window:leader_is_active() then
		-- prefix is sparkles + rocket emoji
		prefix = " " .. utf8.char(0x2728) .. utf8.char(0x1f680) .. " "
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() - 1 ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = arrow_color } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = active_bg } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

local function get_current_working_dir(tab)
	local current_dir = tostring(tab.active_pane.current_working_dir)
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local cwd = string.format(" %s  %s ~ %s  ", "❯", get_current_working_dir(tab))

	return {
		{ Text = cwd },
	}
end)

-- and finally, return the configuration to wezterm
return config

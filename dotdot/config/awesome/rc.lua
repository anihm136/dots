pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local lain = require("lain")

-- Import theme
local beautiful = require("beautiful")
beautiful.init(
	string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME"))
)
-- beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

require("awful.hotkeys_popup.keys")

-- Import notification appearance
require("notifications")

-- ===================================================================
-- Set Up Screen & Connect Signals
-- ===================================================================

{%@@ if profile == "sorcery" @@%}
awful.util.tagnames_1 = { "WS1_1", "WS1_2", "WWW", "MEDIA", "EMACS", "E1" }
awful.util.tagnames_2 = { "WS2_1", "WS2_2", "SOCIAL", "READ", "E2" }
{%@@ elif profile == "apex" @@%}
awful.util.tagnames = {"WS1", "WS2", "WS3", "WWW", "SOCIAL", "MEDIA", "EMACS", "READ", "9"}
{%@@ endif @@%}
-- Define tag layouts
awful.layout.layouts =
	{
		awful.layout.suit.tile,
		awful.layout.suit.max,
		awful.layout.suit.floating,
		lain.layout.centerwork,
	}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end)

-- Handles borders

screen.connect_signal("arrange", function(s)
	local max = s.selected_tag.layout.name == "max"
	local only_one = #s.tiled_clients == 1
	-- use tiled_clients so that other floating windows don't affect the count
	-- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
	for _, c in pairs(s.clients) do
		if (max or only_one) and not c.floating or c.maximized then
			c.border_width = 0
		else
			c.border_width = beautiful.border_width
			c.border_focus = beautiful.border_focus
		end
	end
end)
-- Set up each screen (add tags & panels)
awful.screen.connect_for_each_screen(function(s)
	beautiful.get().at_screen_connect(s)
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the window as a slave (put it at the end of others instead of setting it as master)
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Refocus parent window after transient window closes
local last_focus
client.connect_signal("unfocus", function(c)
	last_focus = c
end)
client.connect_signal("focus", function(c)
	last_focus = nil
end)
client.connect_signal("unmanage", function(c)
	if last_focus == c and c.transient_for then
		client.focus = c.transient_for
		c.transient_for:raise()
	end
end)

-- Change focused window when client is switched
client.connect_signal("focus", function(c)
	if awful.screen.focused() ~= c.screen then
		awful.screen.focus(c.screen)
	end
end)

-- ===================================================================
-- Client Focusing
-- ===================================================================

-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

awful.spawn.easy_async_with_shell("~/.config/awesome/autorun.sh")

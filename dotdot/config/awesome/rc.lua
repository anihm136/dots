-- Load luarocks modules
pcall(require, "luarocks.loader")

local awful = require("awful")
local lain = require("lain")
local gears = require("gears")

-- Import theme
local beautiful = require("beautiful")
beautiful.init(string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME")))

-- Load keybindings
require("keys")

-- Keybinding help
require("awful.hotkeys_popup.keys")

-- Import notification appearance
require("notifications")

-- Set default applications
require("apps.default_apps")

-- UI stuff
require("ui")

-- Define tag layouts
awful.layout.append_default_layouts({
	awful.layout.suit.tile,
	awful.layout.suit.max,
	awful.layout.suit.floating,
	lain.layout.centerwork,
})

-- Load screen configs
require("screens")

-- Load client configs
require("clients")

-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Load client rules
require("rules")

-- Garbage collection (allows for lower memory consumption)
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})

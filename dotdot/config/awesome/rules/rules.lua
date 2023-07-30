local awful = require("awful")

-- define screen height and width
local screen_height = function()
	return awful.screen.focused().geometry.height
end
local screen_width = function()
	return awful.screen.focused().geometry.width
end

-- define module table
local rules = {}

-- return a table of client rules including provided keys / buttons
function rules.create(clientkeys, clientbuttons)
	return {
		{
			-- All clients will match this rule.
			rule = {},
			properties = {
				focus = awful.client.focus.filter,
				raise = true,
				keys = clientkeys,
				buttons = clientbuttons,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen,
				size_hints_honor = false,
				fullscreen = false,
				maximized = false,
				callback = function(c)
					if c.transient_for then
						c:move_to_tag(c.transient_for.first_tag)
					end
					if c.floating then
						awful.placement.centered(c)
					end
				end,
			},
		},
		{
			-- Titlebars
			rule_any = {
				type = { "dialog", "normal" },
			},
			properties = { titlebars_enabled = false },
		},
		{
			-- Set Firefox to always map on the first tag on screen 1.
			rule_any = {
				class = { "firefox", "Brave-browser" },
			},
			properties = {
				screen = 1,
				tag = screen[1].tags[3],
			},
		},
		{
			rule = { class = "Emacs" },
			properties = {
				screen = 1,
				tag = screen[1].tags[5],
			},
		},
		{
			rule_any = {
				class = {
					"thunderbird",
					"discord",
					"Slack",
					"Element",
					"TelegramDesktop",
					"Zulip",
				},
			},
			properties = {
				screen = 2,
				tag = screen[2].tags[3],
			},
		},
		{
			rule_any = {
				class = { "Spotify" },
			},
			properties = {
				screen = 2,
				tag = screen[2].tags[4],
			},
		},
		{
			rule = { class = "Emacs" },
			properties = {
				screen = 1,
				tag = screen[1].tags[5],
			},
		},
		{
			-- Floating clients.
			rule_any = {
				instance = { "DTA", "copyq" },
				class = {
					"Nm-connection-editor",
					"Galculator",
					"Blueberry.py",
					"Tk",
				},
				name = {
					"Event Tester",
					"Steam Guard - Computer Authorization Required",
				},
				role = { "pop-up", "Dialog" },
				type = { "dialog" },
			},
			properties = { floating = true },
		},
		{
			-- Rofi
			rule_any = {
				name = { "rofi" },
			},
			properties = {
				maximized = true,
				ontop = true,
			},
		},
		{
			-- File chooser dialog
			rule_any = {
				role = { "GtkFileChooserDialog" },
			},
			properties = {
				floating = true,
				height = screen_height() * 0.65,
				width = screen_width() * 0.55,
			},
		},
		{
			rule_any = {
				instance = { "www.instagram.com", "web.whatsapp.com", "discord.com" },
			},
			properties = {
				screen = 2,
				tag = screen[2].tags[3],
				floating = false,
			},
		},
		{
			rule_any = {
				class = { "Spotify" },
				instance = { "open.spotify.com" },
			},
			properties = {
				screen = 2,
				tag = screen[2].tags[4],
				floating = false,
			},
		},
		{
			-- Pavucontrol & Bluetooth Devices
			rule_any = {
				class = { "Pavucontrol" },
				name = { "Bluetooth Devices" },
			},
			properties = {
				floating = true,
				callback = function(c)
					c.height = screen_height() * 0.45
					c.width = screen_width() * 0.55
					awful.placement.centered(c)
				end,
			},
		},
	}
end

return rules

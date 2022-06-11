local awful = require("awful")
local beautiful = require("beautiful")

-- Set the window as a slave (put it at the end of others instead of setting it as master)
client.connect_signal("manage", function(c)
	if not awesome.startup then
		awful.client.setslave(c)
	end
end)

-- Prevent clients from being unreachable after screen count changes.
client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

-- Refocus parent window after transient window closes
local last_focus
client.connect_signal("unfocus", function(c)
	last_focus = c
end)
client.connect_signal("focus", function(_)
	last_focus = nil
end)
client.connect_signal("unmanage", function(c)
	if last_focus == c and c.transient_for then
		client.focus = c.transient_for
		c.transient_for:raise()
	end
end)

-- Change focused screen when client is switched
client.connect_signal("focus", function(c)
	if awful.screen.focused() ~= c.screen then
		awful.screen.focus(c.screen)
	end
end)

-- Raise urgent clients
client.connect_signal("request::urgent", function(c)
	c:raise()
end)

-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
	c:activate({
		context = "mouse_enter",
		raise = false,
	})
end)

-- Change border of focused client
client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

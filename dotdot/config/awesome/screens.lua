local awful = require("awful")
local beautiful = require("beautiful")

-- Set up each screen (add tags & panels)
awful.screen.connect_for_each_screen(function(s)
	beautiful.get().at_screen_connect(s)
end)

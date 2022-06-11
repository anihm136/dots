local awful = require("awful")
local beautiful = require("beautiful")

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

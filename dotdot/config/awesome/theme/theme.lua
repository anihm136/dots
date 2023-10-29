local gears = require("gears")
local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi

local my_table = gears.table

local theme = {}
theme.dir = gears.filesystem.get_configuration_dir() .. "theme"
theme.font = "Inter 13"
theme.fg_normal = "#CDD6F4"
theme.bg_normal = "#1E1E2E"
theme.fg_focus = "#1E1E2E"
theme.bg_focus = "#CDD6F4"
theme.fg_urgent = "#1E1E2E"
theme.bg_urgent = "#F2CDCD"
theme.border_width = dpi(1)
theme.border_normal = "#11111B"
theme.border_focus = "#F2CDCD"
theme.taglist_fg_focus = "#F2CDCD"
theme.taglist_bg_focus = "#1E1E2E"
theme.taglist_bg_normal = "#1E1E2E"
theme.titlebar_bg_normal = "#191919"
theme.titlebar_bg_focus = "#262626"
theme.tooltip_bg = "#1E1E2E"
theme.tooltip_fg = "#CDD6F4"
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.layout_centerfair = theme.dir .. "/icons/centerfair.png"
theme.layout_termfair = theme.dir .. "/icons/termfair.png"
theme.layout_centerwork = theme.dir .. "/icons/centerwork.png"
theme.useless_gap = 6
theme.tasklist_disable_icon = true
theme.icon_theme = "breeze-dark"
theme.systray_icon_spacing = 5

function theme.at_screen_connect(s)
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end)
	))

	-- Eminent-like task filtering
	local orig_filter = awful.widget.taglist.filter.all

	-- Taglist label functions
	awful.widget.taglist.filter.all = function(t, args)
		if t.selected or #t:clients() > 0 then
			return orig_filter(t, args)
		end
	end

	require(string.format("theme/screen_%d", s.index)).at_screen_connect(s)
end

return theme

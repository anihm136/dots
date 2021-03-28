local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os

local theme = {}
theme.dir = gears.filesystem.get_configuration_dir() .. "theme"
theme.font = "Overpass 14"
theme.taglist_font = "Kimberley Bl 12"
theme.fg_normal = "#BBBBBB"
theme.fg_focus = "#78A4FF"
theme.bg_normal = "#222222"
theme.bg_focus = "#222222"
theme.fg_urgent = "#000000"
theme.bg_urgent = "#FFFFFF"
theme.taglist_fg_focus = "#FFFFFF"
theme.taglist_bg_focus = "#222222"
theme.taglist_bg_normal = "#222222"
theme.titlebar_bg_normal = "#191919"
theme.titlebar_bg_focus = "#262626"
theme.tooltip_bg = "#222222"
theme.tooltip_fg = "#BBBBBB"
theme.tooltip_font = "Overpass 9"
theme.menu_height = dpi(30)
theme.menu_width = dpi(250)
theme.taglist_squares_sel = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.disk = theme.dir .. "/icons/disk.png"
{%@@ if profile == "apex" @@%}
theme.ac = theme.dir .. "/icons/ac.png"
theme.bat = theme.dir .. "/icons/bat.png"
theme.bat_low = theme.dir .. "/icons/bat_low.png"
theme.bat_no = theme.dir .. "/icons/bat_no.png"
theme.vol = theme.dir .. "/icons/vol.png"
theme.vol_low = theme.dir .. "/icons/vol_low.png"
theme.vol_no = theme.dir .. "/icons/vol_no.png"
theme.vol_mute = theme.dir .. "/icons/vol_mute.png"

local red = "#EB8F8F"
{%@@ endif @@%}
local markup = lain.util.markup

-- Textclock
local mytextclock = wibox.widget.textclock("<span> %I:%M:%S </span>", 1)
mytextclock.font = "Kimberley Bl 12"
mytextclock.forced_width = dpi(84)

-- Calendar
theme.cal = lain.widget.cal({
	attach_to = { mytextclock },
	notification_preset = {
		title = "",
		icon_size = 110,
		margin = 5,
		font = "Overpass Mono 11",
		fg = theme.fg_normal,
		bg = theme.bg_normal,
	},
})

-- /home fs
local fsicon = wibox.widget.imagebox(theme.disk)
local fsbar = wibox.widget{
	forced_height = dpi(1),
	forced_width = dpi(65),
	color = theme.fg_normal,
	background_color = theme.bg_normal,
	margins = 1,
	paddings = 1,
	ticks = true,
	ticks_size = dpi(6),
	widget = wibox.widget.progressbar,
}
theme.fs = lain.widget.fs{
	notification_preset = {
		fg = theme.fg_normal,
		bg = theme.bg_normal,
		font = "Overpass Mono 10.5",
	},
	settings = function()
		if fs_now["/"].percentage < 90 then
			fsbar:set_color(theme.fg_normal)
		else
			fsbar:set_color("#EB8F8F")
		end
		fsbar:set_value(fs_now["/"].percentage / 100)
	end,
}
local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, dpi(2), dpi(7), dpi(4), dpi(4))

local fs_tooltip = awful.tooltip{
	bg = theme.tooltip_bg,
	fg = theme.tooltip_fg,
	font = theme.tooltip_font,
}

fs_tooltip:add_to_object(fswidget)

fswidget:connect_signal("mouse::enter", function()
	fs_tooltip.text = "Storage used: " .. fs_now["/"].percentage .. "%"
end)
--]]

{%@@ if profile == "apex" @@%}
-- Battery
local baticon = wibox.widget.imagebox(theme.bat)
local batbar = wibox.widget {
  forced_height    = dpi(1),
  forced_width     = dpi(65),
  color            = theme.fg_normal,
  background_color = theme.bg_normal,
  margins          = 1,
  paddings         = 1,
  ticks            = true,
  ticks_size       = dpi(6),
  widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
    settings = function()
      if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

      if bat_now.status == "Charging" then
        baticon:set_image(theme.ac)
        if bat_now.perc >= 98 then
          batbar:set_color(green)
        elseif bat_now.perc > 50 then
          batbar:set_color(theme.fg_normal)
        elseif bat_now.perc > 15 then
          batbar:set_color(theme.fg_normal)
        else
          batbar:set_color(red)
        end
      else
        if bat_now.perc >= 98 then
          batbar:set_color(green)
        elseif bat_now.perc > 50 then
          batbar:set_color(theme.fg_normal)
          baticon:set_image(theme.bat)
        elseif bat_now.perc > 15 then
          batbar:set_color(theme.fg_normal)
          baticon:set_image(theme.bat_low)
        else
          batbar:set_color(red)
          baticon:set_image(theme.bat_no)
        end
      end
      batbar:set_value(bat_now.perc / 100)
    end
  })
local batbg = wibox.container.background(batbar, "#474747", gears.shape.rectangle)
local batwidget = wibox.container.margin(batbg, dpi(2), dpi(7), dpi(4), dpi(4))

local bat_tooltip = awful.tooltip{
	bg = theme.tooltip_bg,
	fg = theme.tooltip_fg,
	font = theme.tooltip_font,
}

bat_tooltip:add_to_object(batwidget)

batwidget:connect_signal("mouse::enter", function()
	bat_tooltip.text = "Battery left: " .. bat_now.perc .. "%"
end)

-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar{
	width = dpi(65),
	height = dpi(1),
	border_width = 0,
	ticks = true,
	ticks_size = dpi(6),
	notification_preset = { font = theme.font },
	settings = function()
		if volume_now.status == "off" then
			volicon:set_image(theme.vol_mute)
		elseif volume_now.level == 0 then
			volicon:set_image(theme.vol_no)
		elseif volume_now.level <= 50 then
			volicon:set_image(theme.vol_low)
		else
			volicon:set_image(theme.vol)
		end
	end,
	colors = {
		background = theme.bg_normal,
		mute = red,
		unmute = theme.fg_normal,
	},
}
theme.volume.tooltip.fg = theme.tooltip_fg
theme.volume.tooltip.bg = theme.tooltip_bg
theme.volume.tooltip.font = theme.tooltip_font

local volumebg =
	wibox.container.background(
		theme.volume.bar,
		"#474747",
		gears.shape.rectangle
	)
local volumewidget =
	wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))
{%@@ endif @@%}

-- Separators
local first = wibox.widget.textbox(markup.font("Overpass Mono 3", " "))
local spr = wibox.widget.textbox(" ")
local small_spr = wibox.widget.textbox(markup.font("Overpass Mono 4", " "))
local bar_spr =
	wibox.widget.textbox(
		markup.font("Overpass Mono 3", " ") .. markup.fontfg(
			theme.font,
			"#777777",
			"|"
		) .. markup.font("Overpass Mono 5", " ")
	)

-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
awful.widget.taglist.filter.all = function(t, args)
	if t.selected or #t:clients() > 0 then
		return orig_filter(t, args)
	end
end

function theme.at_screen_connect(s)
	-- Tags
	{%@@ if profile == "sorcery" @@%}
	local tagnames = awful.util.tagnames_1
	{%@@ elif profile == "apex" @@%}
	local tagnames = awful.util.tagnames
	{%@@ endif @@%}
	for i, tag in pairs(tagnames) do
		awful.tag.add(tag, {
			-- icon = tag.icon,
			-- icon_only = true,
			layout = awful.layout.layouts[1],
			screen = s,
			selected = i == 1,
		})
	end

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist{
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.taglist_buttons,
		style = { font = theme.taglist_font },
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist{
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = awful.util.tasklist_buttons,
		style = { font = theme.font },
	}

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = theme.menu_height,
		bg = theme.bg_normal,
		fg = theme.fg_normal,
	})

	-- Add widgets to the wibox
	s.mywibox:setup{
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			small_spr,
			s.mylayoutbox,
			first,
			bar_spr,
			s.mytaglist,
			first,
		},
		s.mytasklist, -- Middle widget
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			bar_spr,
			{%@@ if profile == "apex" @@%}
			baticon,
			batwidget,
			bar_spr,
			volicon,
			volumewidget,
			bar_spr,
			{%@@ endif @@%}
			fsicon,
			fswidget,
			bar_spr,
			mytextclock,
		},
	}
end

return theme

local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os
local my_table = gears.table
require("pl.stringx").import()

local theme = {}
theme.dir = gears.filesystem.get_configuration_dir() .. "theme"
theme.font = "Overpass 13"
theme.taglist_font = "Kimberley Bl 11"
theme.fg_normal = "#BBBBBB"
theme.fg_focus = "#78A4FF"
theme.bg_normal = "#222222"
theme.bg_focus = "#222222"
theme.fg_urgent = "#000000"
theme.bg_urgent = "#FFFFFF"
theme.tooltip_bg = "#222222"
theme.tooltip_fg = "#BBBBBB"
theme.tooltip_font = "Overpass 8"
theme.menu_height = dpi(24)
theme.menu_width = dpi(250)
theme.vol = theme.dir .. "/icons/vol.png"
theme.vol_low = theme.dir .. "/icons/vol_low.png"
theme.vol_no = theme.dir .. "/icons/vol_no.png"
theme.vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.play = theme.dir .. "/icons/play.png"
theme.pause = theme.dir .. "/icons/pause.png"
theme.stop = theme.dir .. "/icons/stop.png"

local markup = lain.util.markup
local red = "#EB8F8F"

-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar{
	width = dpi(59),
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

theme.volume.bar:buttons(
	my_table.join(
		awful.button({}, 1, function()
			os.execute(string.format("%s -e alsamixer", awful.terminal))
		end),
		awful.button({}, 2, function()
			os.execute(
				string.format(
					"%s set %s 100%%",
					theme.volume.cmd,
					theme.volume.channel
				)
			)
			theme.volume.update()
		end),
		awful.button({}, 3, function()
			os.execute(
				string.format(
					"%s set %s toggle",
					theme.volume.cmd,
					theme.volume.togglechannel or theme.volume.channel
				)
			)
			theme.volume.update()
		end),
		awful.button({}, 4, function()
			os.execute(
				string.format(
					"%s set %s 1%%+",
					theme.volume.cmd,
					theme.volume.channel
				)
			)
			theme.volume.update()
		end),
		awful.button({}, 5, function()
			os.execute(
				string.format(
					"%s set %s 1%%-",
					theme.volume.cmd,
					theme.volume.channel
				)
			)
			theme.volume.update()
		end)
	)
)
local volumebg =
	wibox.container.background(
		theme.volume.bar,
		"#474747",
		gears.shape.rectangle
	)
local volumewidget =
	wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))

local mocp, mocp_timer = awful.widget.watch("mocp -i", 1, function(
widget,
	stdout
)
	local mocp_now = {
		state = "N/A",
		artist = "N/A",
		title = "N/A",
		album = "N/A",
		cur_time = "`",
		tot_time = "`",
	}

	if string.match(stdout, "SongTitle: ([^\n]+)\n") then
		mocp_now["title"] = string.match(stdout, "SongTitle: ([^\n]+)\n")
	end
	if string.match(stdout, "State: (%a+)") then
		mocp_now["state"] = string.match(stdout, "State: (%a+)")
	end
	if string.match(stdout, "Artist: ([^\n]+)\n") then
		mocp_now["artist"] = string.match(stdout, "Artist: ([^\n]+)\n")
	end
	if string.match(stdout, "CurrentTime: ([%d%p ]+)\n") then
		mocp_now["cur_time"] = string.match(stdout, "CurrentTime: ([%d%p ]+)")
	end
	if string.match(stdout, "TotalTime: ([%d%p ]+)\n") then
		mocp_now["tot_time"] = string.match(stdout, "TotalTime: ([%d%p ]+)")
	end

	-- customize here
	local total_length = #mocp_now.artist + #mocp_now.title
	local percent = 40 / total_length

	local max_artist = math.floor(#mocp_now.artist * percent)
	local max_title = math.floor(#mocp_now.title * percent)

	local info_string = " " .. mocp_now.artist .. " - " .. mocp_now.title

	local wistring =
		" " .. mocp_now.artist:shorten(
			max_artist
		) .. " - " .. mocp_now.title:shorten(
			max_title
		) .. "   " .. mocp_now.cur_time .. " [" .. mocp_now.tot_time .. "] "
	if mocp_now.state == "PAUSE" then
		wistring = " ⏸ " .. wistring
	elseif mocp_now.state == "PLAY" then
		wistring = " ▶ " .. wistring
	elseif mocp_now.state == "STOP" then
		wistring = " ■ " .. wistring
	end
	widget:set_font("Overpass 9")
	widget:set_text(wistring)
	widget.info_string = info_string
end)
local music_tooltip = awful.tooltip{
	bg = theme.tooltip_bg,
	fg = theme.tooltip_fg,
	font = theme.tooltip_font,
}

music_tooltip:add_to_object(mocp)

mocp:connect_signal("mouse::enter", function()
	music_tooltip.text = mocp.info_string
end)

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
	local layout = awful.layout.layouts[1]
	for i, tag in pairs(awful.util.tagnames_2) do
		if i == 3 then
			layout = awful.layout.layouts[2]
		else
			layout = awful.layout.layouts[1]
		end
		awful.tag.add(tag, {
			-- icon = tag.icon,
			-- icon_only = true,
			layout = layout,
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
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mocp,
			bar_spr,
			volicon,
			volumewidget,
		},
	}
end

return theme

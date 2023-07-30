local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local deepcopy = require("utils").deepcopy

local screen_theme = deepcopy(require("beautiful").get())
screen_theme.font = "Inter 14"
screen_theme.taglist_font = "Inter Black 12"
screen_theme.menu_height = dpi(35)
screen_theme.menu_width = dpi(250)
screen_theme.taglist_squares_sel = screen_theme.dir .. "/icons/square_unsel.png"
screen_theme.taglist_squares_unsel = screen_theme.dir .. "/icons/square_unsel.png"
screen_theme.disk = screen_theme.dir .. "/icons/disk.png"
{%@@ if profile == "apex" @@%}
screen_theme.ac = screen_theme.dir .. "/icons/ac.png"
screen_theme.bat = screen_theme.dir .. "/icons/bat.png"
screen_theme.bat_low = screen_theme.dir .. "/icons/bat_low.png"
screen_theme.bat_no = screen_theme.dir .. "/icons/bat_no.png"
screen_theme.vol = screen_theme.dir .. "/icons/vol.png"
screen_theme.vol_low = screen_theme.dir .. "/icons/vol_low.png"
screen_theme.vol_no = screen_theme.dir .. "/icons/vol_no.png"
screen_theme.vol_mute = screen_theme.dir .. "/icons/vol_mute.png"

local red = "#EB8F8F"
local green = "#87ed87"
{%@@ endif @@%}

-- Textclock
local clock = wibox.widget.textclock("%a, %d %b %l:%M %p", 60)
clock.font = "Inter Black 12"
clock.align = "center"
clock.forced_width = dpi(190)

-- Calendar
local month_calendar = awful.widget.calendar_popup.month({
	margin = dpi(10),
	style_header = {
		border_width = 0,
		bg_color = screen_theme.bg_focus,
		fg_color = screen_theme.bg_normal,
	},
	style_normal = { border_width = 0 },
	style_focus = {
		border_width = 0,
		bg_color = screen_theme.bg_focus,
		fg_color = screen_theme.bg_normal,
	},
	style_weekday = { border_width = 0 },
})
month_calendar:attach(clock, "tr")

-- /home fs
local fsicon = wibox.widget.imagebox(screen_theme.disk)
local fsbar = wibox.widget({
	forced_height = dpi(1),
	forced_width = dpi(65),
	color = screen_theme.fg_normal,
	background_color = screen_theme.bg_normal,
	margins = 1,
	paddings = 1,
	ticks = true,
	ticks_size = dpi(6),
	widget = wibox.widget.progressbar,
})
screen_theme.fs = lain.widget.fs({
	notification_preset = {
		fg = screen_theme.fg_normal,
		bg = screen_theme.bg_normal,
		font = "Overpass Mono 10.5",
		title = "Storage overview",
		width = 0,
	},
	showpopup = "off",
	settings = function()
		if fs_now["/"].percentage < 90 then
			fsbar:set_color(screen_theme.fg_normal)
		else
			fsbar:set_color("#EB8F8F")
		end
		fsbar:set_value(fs_now["/"].percentage / 100)
	end,
})
local fswidget = wibox.widget({
	{
		fsbar,
		widget = wibox.container.background,
		bg = "#474747",
		shape = gears.shape.rectangle,
	},
	widget = wibox.container.margin,
	margins = 5,
})

fswidget:connect_signal("mouse::enter", function()
	screen_theme.fs.show(0)
end)
fswidget:connect_signal("mouse::leave", function()
	screen_theme.fs.hide()
end)
--]]

{%@@ if profile == "apex" @@%}
-- Battery
local baticon = wibox.widget.imagebox(screen_theme.bat)
local batbar = wibox.widget {
  forced_height    = dpi(1),
  forced_width     = dpi(65),
  color            = screen_theme.fg_normal,
  background_color = screen_theme.bg_normal,
  margins          = 1,
  paddings         = 1,
  ticks            = true,
  ticks_size       = dpi(6),
  widget           = wibox.widget.progressbar,
}
local batupd = lain.widget.bat({
		timeout = 10,
    settings = function()
      if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

      if bat_now.status == "Charging" then
        baticon:set_image(screen_theme.ac)
        if bat_now.perc >= 98 then
          batbar:set_color(green)
        elseif bat_now.perc > 50 then
          batbar:set_color(screen_theme.fg_normal)
        elseif bat_now.perc > 15 then
          batbar:set_color(screen_theme.fg_normal)
        else
          batbar:set_color(red)
        end
      else
        if bat_now.perc >= 98 then
          batbar:set_color(green)
        elseif bat_now.perc > 50 then
          batbar:set_color(screen_theme.fg_normal)
          baticon:set_image(screen_theme.bat)
        elseif bat_now.perc > 15 then
          batbar:set_color(screen_theme.fg_normal)
          baticon:set_image(screen_theme.bat_low)
        else
          batbar:set_color(red)
          baticon:set_image(screen_theme.bat_no)
        end
      end
      batbar:set_value(bat_now.perc / 100)
    end
  })
local batbg = wibox.container.background(batbar, "#474747", gears.shape.rectangle)
local batwidget = wibox.container.margin(batbg, dpi(2), dpi(7), dpi(4), dpi(4))

local bat_tooltip = awful.tooltip{
	bg = screen_theme.tooltip_bg,
	fg = screen_theme.tooltip_fg,
	font = screen_theme.tooltip_font,
	objects = { batwidget }
}

batwidget:connect_signal("mouse::enter", function()
	local text
	if bat_now.status == "Charging" then
	  text = "Charging: "
	else
		text = "Battery left: "
	end
	bat_tooltip.text = text .. bat_now.perc .. "% [" .. bat_now.time .. "]"
end)

-- ALSA volume bar
local volicon = wibox.widget.imagebox(screen_theme.vol)
screen_theme.volume = lain.widget.alsabar{
	width = dpi(65),
	height = dpi(1),
	border_width = 0,
	ticks = true,
	ticks_size = dpi(6),
	notification_preset = { font = screen_theme.font },
	settings = function()
		if volume_now.status == "off" then
			volicon:set_image(screen_theme.vol_mute)
		elseif volume_now.level == 0 then
			volicon:set_image(screen_theme.vol_no)
		elseif volume_now.level <= 50 then
			volicon:set_image(screen_theme.vol_low)
		else
			volicon:set_image(screen_theme.vol)
		end
	end,
	colors = {
		background = screen_theme.bg_normal,
		mute = red,
		unmute = screen_theme.fg_normal,
	},
}
screen_theme.volume.tooltip.fg = screen_theme.tooltip_fg
screen_theme.volume.tooltip.bg = screen_theme.tooltip_bg
screen_theme.volume.tooltip.font = screen_theme.tooltip_font

local volumebg =
	wibox.container.background(
		screen_theme.volume.bar,
		"#474747",
		gears.shape.rectangle
	)
local volumewidget =
	wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))
{%@@ endif @@%}


function screen_theme.at_screen_connect(s)
	-- Tags
	{%@@ if profile == "sorcery" @@%}
	local tagnames = { "WS1_1", "WS1_2", "WWW", "MEDIA", "EMACS", "E1" }
	{%@@ elif profile == "apex" @@%}
	local tagnames = {"WS1", "WS2", "WS3", "WWW", "SOCIAL", "MEDIA", "EMACS", "READ", "9"}
	{%@@ endif @@%}
	for i, tag in pairs(tagnames) do
		awful.tag.add(tag, {
			layout = awful.layout.layouts[1],
			screen = s,
			selected = i == 1,
		})
	end

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.taglist_buttons,
		style = { font = screen_theme.taglist_font },
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = awful.util.tasklist_buttons,
		style = {
			font = screen_theme.font,
			border_width = 1,
			border_color = "#777777",
			shape = function(cr, width, height)
				return gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true)
			end,
		},
		layout = {
			layout = wibox.layout.flex.horizontal,
			spacing = 10,
		},
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
						align = "right",
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		ontop = true,
		stretch = true,
		widget = {
			layout = wibox.layout.align.horizontal,
			{
				{
					layout = wibox.layout.fixed.horizontal,
					s.mylayoutbox,
					s.mytaglist,
					spacing = 10,
					spacing_widget = wibox.widget.separator({
						thickness = 2,
						span_ratio = 0.8,
						color = "#777777",
					}),
				},
				widget = wibox.container.margin,
				margins = { left = 5 },
			},
			{
				s.mytasklist,
				widget = wibox.container.margin,
				margins = { left = 20, right = 20 },
			},
			{
				{
					layout = wibox.layout.fixed.horizontal,
					{
						wibox.widget.systray(),
						widget = wibox.container.margin,
						margins = { top = 3, bottom = 3 },
					},
					{%@@ if profile == "apex" @@%}
					{
						baticon,
						batwidget,
						layout = wibox.layout.align.horizontal,
					},
					{
						volicon,
						volumewidget,
						layout = wibox.layout.align.horizontal,
					},
					{%@@ endif @@%}
					{
						fsicon,
						fswidget,
						layout = wibox.layout.align.horizontal,
					},
					clock,
					spacing = 10,
					spacing_widget = wibox.widget.separator({
						thickness = 2,
						span_ratio = 0.8,
						color = "#777777",
					}),
				},
				widget = wibox.container.margin,
				margins = { right = 5 },
			},
		},
	})
end

return screen_theme

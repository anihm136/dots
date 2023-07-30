local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local bling = require("bling")
local gears = require("gears")
local awful = require("awful")

local default_icon = gears.filesystem.get_configuration_dir() .. "widgets/icons/music.png"

local popup_art = wibox.widget({
	image = default_icon,
	resize = true,
	forced_height = dpi(80),
	forced_width = dpi(80),
	widget = wibox.widget.imagebox,
})

local title_widget = wibox.widget({
	markup = "Nothing Playing",
	align = "right",
	valign = "center",
	ellipsize = "end",
	forced_width = 180,
	widget = wibox.widget.textbox,
})

local popup_player = wibox.widget({
	markup = "-",
	align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})

local popup_title = wibox.widget({
	markup = "-",
	align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})

local popup_artist = wibox.widget({
	markup = "-",
	align = "left",
	valign = "center",
	widget = wibox.widget.textbox,
})

local popup_play_pause = wibox.widget({
	markup = "►",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})
local popup_previous = wibox.widget({
	markup = "⇤",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})
local popup_next = wibox.widget({
	markup = "⇥",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})
local popup_controls = wibox.widget({
	{
		popup_previous,
		popup_play_pause,
		popup_next,
		layout = wibox.layout.fixed.horizontal,
		spacing = 25,
	},
	widget = wibox.container.place,
	halign = "center",
})

local function wrap(widget, left_text)
	return wibox.widget({
		{
			widget = wibox.widget.textbox,
			markup = left_text,
			align = "left",
		},
		widget,
		layout = wibox.layout.fixed.horizontal,
		spacing = 3,
	})
end

local player_popup = awful.popup({
	widget = {
		{
			{
				{
					popup_art,
					widget = wibox.container.margin,
					margins = dpi(3),
				},
				{
					wrap(popup_player, "Playing on"),
					wrap(popup_title, "<b>Song:</b>"),
					wrap(popup_artist, "<b>Artist:</b>"),
					popup_controls,
					layout = wibox.layout.fixed.vertical,
					spacing = 5,
				},
				layout = wibox.layout.align.horizontal,
			},
			widget = wibox.container.margin,
			margins = dpi(5),
		},
		widget = wibox.container.background,
		border_width = 1,
		border_color = "#FFFFFF",
	},
	visible = false,
	ontop = true,
	screen = 2,
})

-- Get Song Info
local playerctl = bling.signal.playerctl.lib()
playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
	if title == "" then
		title = "-"
	end
	if artist == "" then
		artist = "-"
	end

	popup_art:set_image(gears.surface.load_uncached(album_path))
	popup_player:set_markup_silently("<b>" .. player_name .. "</b>")
	title_widget:set_markup_silently(title)
	popup_title:set_markup_silently(title)
	popup_artist:set_markup_silently(artist)

	local position = (awful.placement.top_right + awful.placement.no_offscreen)
	position(player_popup, { margins = dpi(10) })
end)

playerctl:connect_signal("playback_status", function(_, playing, _)
	if playing then
		popup_play_pause.markup = "▐▐"
	else
		popup_play_pause.markup = "►"
	end
end)

local hide_popup_timer = gears.timer({
	timeout = 0.5,
	callback = function()
		player_popup.visible = false
	end,
})
title_widget:connect_signal("mouse::enter", function()
	(awful.placement.top_right + awful.placement.no_offscreen)(player_popup, { margins = dpi(10) })
	player_popup.visible = true
	hide_popup_timer:stop()
end)
title_widget:connect_signal("mouse::leave", function()
	hide_popup_timer:start()
end)
player_popup:connect_signal("mouse::enter", function()
	hide_popup_timer:stop()
end)
player_popup:connect_signal("mouse::leave", function()
	hide_popup_timer:start()
end)

popup_play_pause:buttons(gears.table.join(awful.button({}, 1, function()
	playerctl:play_pause()
end)))
popup_previous:buttons(gears.table.join(awful.button({}, 1, function()
	playerctl:previous()
end)))
popup_next:buttons(gears.table.join(awful.button({}, 1, function()
	playerctl:next()
end)))

return wibox.widget({
	{ title_widget, widget = wibox.container.background, fg = "#F2CDCD" },
	widget = wibox.container.margin,
	right = 10,
})

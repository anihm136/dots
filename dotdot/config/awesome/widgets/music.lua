local wibox = require("wibox")
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
	align = "center",
	valign = "center",
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
					margins = dpi(3)
				},
				{
					wrap(popup_title, "<b>Song:</b>"),
					wrap(popup_artist, "<b>Artist:</b>"),
					wrap(popup_player, "Playing on"),
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
	local short_title = title
	if title == "" then
		short_title = "Nothing playing"
		title = "-"
	elseif #title > 30 then
		short_title = title:sub(1, 30) .. "..."
	end
	if artist == "" then
		artist = "-"
	end

	popup_art:set_image(gears.surface.load_uncached(album_path))
	popup_player:set_markup_silently("<b>" .. player_name .. "</b>")
	title_widget:set_markup_silently(short_title)
	popup_title:set_markup_silently(title)
	popup_artist:set_markup_silently(artist)
end)

title_widget:connect_signal("mouse::enter", function()
	(awful.placement.top_right + awful.placement.no_offscreen)(player_popup, { margins = dpi(10) })
	player_popup.visible = true
end)
title_widget:connect_signal("mouse::leave", function()
	player_popup.visible = false
end)

return title_widget

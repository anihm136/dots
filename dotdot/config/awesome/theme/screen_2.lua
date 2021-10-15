local gears = require('gears')
local lain = require('lain')
local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful.xresources').apply_dpi
local deepcopy = require('utils').deepcopy

local my_table = gears.table
require('pl.stringx').import()

local screen_theme = deepcopy(require('beautiful').get())
screen_theme.font = 'Inter 13'
screen_theme.taglist_font = 'Inter Black 11'
screen_theme.tooltip_font = 'Inter 6'
screen_theme.menu_height = dpi(24)
screen_theme.menu_width = dpi(250)
screen_theme.vol = screen_theme.dir .. '/icons/vol.png'
screen_theme.vol_low = screen_theme.dir .. '/icons/vol_low.png'
screen_theme.vol_no = screen_theme.dir .. '/icons/vol_no.png'
screen_theme.vol_mute = screen_theme.dir .. '/icons/vol_mute.png'
screen_theme.play = screen_theme.dir .. '/icons/play.png'
screen_theme.pause = screen_theme.dir .. '/icons/pause.png'
screen_theme.stop = screen_theme.dir .. '/icons/stop.png'
screen_theme.widget_music = screen_theme.dir .. '/icons/note.png'
screen_theme.widget_music_on = screen_theme.dir .. '/icons/note_on.png'

local markup = lain.util.markup
local red = '#EB8F8F'

-- ALSA volume bar
local volicon = wibox.widget.imagebox(screen_theme.vol)
screen_theme.volume = lain.widget.alsabar{
	width = dpi(59),
	border_width = 0,
	ticks = true,
	ticks_size = dpi(6),
	notification_preset = { font = screen_theme.font },
	settings = function()
		if volume_now.status == 'off' then
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

screen_theme.volume.bar:buttons(
	my_table.join(
		awful.button({}, 1, function()
			awful.spawn(string.format('%s -e alsamixer', awful.util.terminal))
		end),
		awful.button({}, 2, function()
			os.execute(
				string.format(
					'%s -D %s set %s 100%%',
					screen_theme.volume.cmd,
					screen_theme.volume.device,
					screen_theme.volume.channel
				)
			)
			screen_theme.volume.update()
		end),
		awful.button({}, 3, function()
			os.execute(
				string.format(
					'%s -D %s set %s toggle',
					screen_theme.volume.cmd,
					screen_theme.volume.device,
					screen_theme.volume.togglechannel or screen_theme.volume.channel
				)
			)
			screen_theme.volume.update()
		end),
		awful.button({}, 4, function()
			os.execute(
				string.format(
					'%s -D %s set %s 1%%+',
					screen_theme.volume.cmd,
					screen_theme.volume.device,
					screen_theme.volume.channel
				)
			)
			screen_theme.volume.update()
		end),
		awful.button({}, 5, function()
			os.execute(
				string.format(
					'%s -D %s set %s 1%%-',
					screen_theme.volume.cmd,
					screen_theme.volume.device,
					screen_theme.volume.channel
				)
			)
			screen_theme.volume.update()
		end)
	)
)
local volumewidget = wibox.widget{
	{
		screen_theme.volume.bar,
		widget = wibox.container.background,
		bg = '#474747',
		shape = gears.shape.rectangle,
	},
	widget = wibox.container.margin,
	margins = {
		top = 3,
		bottom = 3,
		left = 4,
		right = 4,
	},
}

-- MPD
local musicplr =
	string.format('%s -T Music -e ncmpcpp', awful.util.terminal)
screen_theme.mpd = lain.widget.mpd{
	settings = function()
		local total_length = #mpd_now.artist + #mpd_now.title
		local percent = 35 / total_length

		local max_artist = math.floor(#mpd_now.artist * percent)
		local max_title = math.floor(#mpd_now.title * percent)
		mpd_now.artist = mpd_now.artist:shorten(max_artist)
		mpd_now.title = mpd_now.title:shorten(max_title)
		if mpd_now.state == 'play' then
			artist = ' ' .. mpd_now.artist .. ' '
			title = mpd_now.title .. ' '
		elseif mpd_now.state == 'pause' then
			artist = ' mpd '
			title = 'paused '
		else
			artist = ''
			title = ''
		end

		widget:set_markup(
			markup.font("Inter 9", markup('#78FFA4', artist) .. title)
		)
	end,
	notify = "off",
}
screen_theme.mpd.widget:buttons(
	my_table.join(
		awful.button({ 'Mod4' }, 1, function()
			awful.spawn(musicplr)
		end),
		awful.button({}, 1, function()
			os.execute('mpc prev')
			screen_theme.mpd.update()
		end),
		awful.button({}, 2, function()
			os.execute('mpc toggle')
			screen_theme.mpd.update()
		end),
		awful.button({}, 3, function()
			os.execute('mpc next')
			screen_theme.mpd.update()
		end)
	)
)

-- Separators
local first = wibox.widget.textbox(markup.font('Inter Mono 3', ' '))
local spr = wibox.widget.textbox(' ')
local small_spr = wibox.widget.textbox(markup.font('Inter Mono 4', ' '))
local bar_spr =
	wibox.widget.textbox(
		markup.font('Inter Mono 5', ' ') .. markup.fontfg(
			screen_theme.font,
			'#777777',
			'|'
		) .. markup.font('Inter Mono 5', ' ')
	)

function screen_theme.at_screen_connect(s)
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
		style = { font = screen_theme.taglist_font },
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist{
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = awful.util.tasklist_buttons,
		style = { font = screen_theme.font },
		widget_template = {
			{
				{
					{
						id = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = 'background_role',
			widget = wibox.container.background,
		},
	}

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = 'top',
		screen = s,
		height = screen_theme.menu_height,
		bg = screen_theme.bg_normal,
		fg = screen_theme.fg_normal,
	})

	-- Add widgets to the wibox
	s.mywibox:setup{
		layout = wibox.layout.align.horizontal,
		{
			{
				layout = wibox.layout.fixed.horizontal,
				s.mylayoutbox,
				first,
				bar_spr,
				s.mytaglist,
				first,
				s.mypromptbox,
			},
			widget = wibox.container.margin,
			margins = { left = 5 },
		},
		s.mytasklist,
		{
			{
				layout = wibox.layout.fixed.horizontal,
				-- wibox.container.background(mpdicon, screen_theme.bg_normal),
				wibox.container.background(
					screen_theme.mpd.widget,
					screen_theme.bg_focus
				),
				bar_spr,
				volicon,
				small_spr,
				volumewidget,
			},
			widget = wibox.container.margin,
			margins = { right = 5 },
		},
	}
end


return screen_theme

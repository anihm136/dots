local gears = require('gears')
local lain = require('lain')
local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful.xresources').apply_dpi
local deepcopy = require('utils').deepcopy

local my_table = gears.table
require('pl.stringx').import()

local screen_theme = deepcopy(require('beautiful').get())
screen_theme.font = 'Overpass 13'
screen_theme.taglist_font = 'Kimberley Bl 11'
screen_theme.tooltip_font = 'Overpass 8'
screen_theme.menu_height = dpi(24)
screen_theme.menu_width = dpi(250)
screen_theme.vol = screen_theme.dir .. '/icons/vol.png'
screen_theme.vol_low = screen_theme.dir .. '/icons/vol_low.png'
screen_theme.vol_no = screen_theme.dir .. '/icons/vol_no.png'
screen_theme.vol_mute = screen_theme.dir .. '/icons/vol_mute.png'
screen_theme.play = screen_theme.dir .. '/icons/play.png'
screen_theme.pause = screen_theme.dir .. '/icons/pause.png'
screen_theme.stop = screen_theme.dir .. '/icons/stop.png'

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
			os.execute(string.format('%s -e alsamixer', awful.terminal))
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
local volumebg =
	wibox.container.background(
		screen_theme.volume.bar,
		'#474747',
		gears.shape.rectangle
	)
local volumewidget =
	wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))

local mocp, mocp_timer = awful.widget.watch('mocp -i', 1, function(
widget,
	stdout
)
	local mocp_now = {
		state = 'N/A',
		artist = 'N/A',
		title = 'N/A',
		album = 'N/A',
		cur_time = '`',
		tot_time = '`',
	}

	if string.match(stdout, 'SongTitle: ([^\n]+)\n') then
		mocp_now['title'] = string.match(stdout, 'SongTitle: ([^\n]+)\n')
	end
	if string.match(stdout, 'State: (%a+)') then
		mocp_now['state'] = string.match(stdout, 'State: (%a+)')
	end
	if string.match(stdout, 'Artist: ([^\n]+)\n') then
		mocp_now['artist'] = string.match(stdout, 'Artist: ([^\n]+)\n')
	end
	if string.match(stdout, 'CurrentTime: ([%d%p ]+)\n') then
		mocp_now['cur_time'] = string.match(stdout, 'CurrentTime: ([%d%p ]+)')
	end
	if string.match(stdout, 'TotalTime: ([%d%p ]+)\n') then
		mocp_now['tot_time'] = string.match(stdout, 'TotalTime: ([%d%p ]+)')
	end

	-- customize here
	local total_length = #mocp_now.artist + #mocp_now.title
	local percent = 35 / total_length

	local max_artist = math.floor(#mocp_now.artist * percent)
	local max_title = math.floor(#mocp_now.title * percent)

	local info_string = ' ' .. mocp_now.artist .. ' - ' .. mocp_now.title

	local wistring =
		' ' .. mocp_now.artist:shorten(
			max_artist
		) .. ' - ' .. mocp_now.title:shorten(
			max_title
		) .. '   ' .. mocp_now.cur_time .. ' [' .. mocp_now.tot_time .. '] '
	if mocp_now.state == 'PAUSE' then
		wistring = ' ⏸ ' .. wistring
	elseif mocp_now.state == 'PLAY' then
		wistring = ' ▶ ' .. wistring
	elseif mocp_now.state == 'STOP' then
		wistring = ' ■ ' .. wistring
	end
	widget:set_font('Overpass 9')
	widget:set_text(wistring)
	widget.info_string = info_string
end)
local music_tooltip = awful.tooltip{
	bg = screen_theme.tooltip_bg,
	fg = screen_theme.tooltip_fg,
	font = screen_theme.tooltip_font,
}

music_tooltip:add_to_object(mocp)

mocp:connect_signal('mouse::enter', function()
	music_tooltip.text = mocp.info_string
end)

-- Separators
local first = wibox.widget.textbox(markup.font('Overpass Mono 3', ' '))
local spr = wibox.widget.textbox(' ')
local small_spr = wibox.widget.textbox(markup.font('Overpass Mono 4', ' '))
local bar_spr =
	wibox.widget.textbox(
		markup.font('Overpass Mono 5', ' ') .. markup.fontfg(
			screen_theme.font,
			'#777777',
			'|'
		) .. markup.font('Overpass Mono 5', ' ')
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

return screen_theme

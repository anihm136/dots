local naughty = require('naughty')
local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')
local awful = require('awful')
local dpi = beautiful.xresources.apply_dpi
local utils = require('utils')

-- ===================================================================
-- Theme Definitions
-- ===================================================================

-- These are no-clear settings: cannot set the entire table at once
local defaults = {
	ontop = true,
	icon_size = dpi(24),
	timeout = 5,
	title = 'Notification',
	margin = dpi(10),
	position = 'top_right',
	width = dpi(500),
	border_width = 0,
	max_height = dpi(150),
	shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, dpi(10))
	end,
}
for k, v in pairs(defaults) do
	naughty.config.defaults[k] = v
end

local presets = {
	normal = {
		font = beautiful.title_font,
		fg = beautiful.fg_normal,
		bg = beautiful.bg_normal,
	},
	low = {
		font = beautiful.title_font,
		fg = beautiful.fg_normal,
		bg = beautiful.bg_normal,
		-- fg = '#ffffff',
		-- bg = '#ff0000',
		timeout = 2,
	},
	critical = {
		font = beautiful.title_font,
		fg = '#ffffff',
		bg = '#ff0000',
	},
}

for preset, settings in pairs(presets) do
	for k, v in pairs(settings) do
		naughty.config.presets[preset][k] = v
	end
end

-- Debug
-- naughty.config.defaults.timeout = 0
-- naughty.config.presets.normal.timeout = 0
-- naughty.config.presets.critical.timeout = 0
-- naughty.config.presets.low.timeout = 0

naughty.config.padding = dpi(30)
naughty.config.spacing = dpi(30)
naughty.config.icon_dirs =
	{
		'/usr/share/icons/Sardi/scalable/actions/',
		'/usr/share/icons/Sardi/scalable/animations/',
		'/usr/share/icons/Sardi/scalable/apps/',
		'/usr/share/icons/Sardi/scalable/categories/',
		'/usr/share/icons/Sardi/scalable/devices/',
		'/usr/share/icons/Sardi/scalable/emblems/',
		'/usr/share/icons/Sardi/scalable/mimetypes/',
		'/usr/share/icons/Sardi/scalable/notifications/',
		'/usr/share/icons/Sardi/scalable/panel/',
		'/usr/share/icons/Sardi/scalable/places/',
		'/usr/share/icons/Sardi/scalable/status/',
	}

naughty.config.notify_callback = function(args)
	if args.actions ~= nil and #args.actions > 0 then
		args.timeout = 0.0
		args.ignore_suspend = true
	end
	return args
end

naughty.connect_signal('request::display', function(notif, _, args)
	args.screen = awful.screen.focused()
	args.title = '<b>' .. args.title .. '</b>'
	local bound_strategy
	if args.width or args.height or (args.preset and args.preset.width) or (args.preset and args.preset.height) then
		bound_strategy = 'max'
	else
		bound_strategy = 'exact'
	end
	naughty.layout.box{
		notification = notif,
		widget_template = {
			{
				{
					{
						{
							naughty.widget.icon,
							{
								{
									widget = wibox.widget.textbox,
									text = notif.title,
									font = "Inter Black 13"
								},
								naughty.widget.message,
								spacing = 12,
								layout = wibox.layout.fixed.vertical,
							},
							fill_space = true,
							spacing = 4,
							layout = wibox.layout.fixed.horizontal,
						},
						naughty.list.actions,
						spacing = 10,
						layout = wibox.layout.fixed.vertical,
					},
					widget = wibox.container.margin,
					margins = defaults.margin
				},
				id = 'background_role',
				widget = naughty.container.background,
			},
			strategy = bound_strategy,
			widget = wibox.container.constraint,
		},
		shape = defaults.shape,
	}
end)

naughty.connect_signal('request::icon', function(notif, context, hints)
	if context ~= 'app_icon' then return end

	local path =
		utils.lookup_icon(
			hints.app_icon,
			naughty.config.icon_dirs
		) or utils.lookup_icon(hints.app_icon:lower(), naughty.config.icon_dirs)

	if path then
		notif.icon = path
	end
end)
naughty.connect_signal('request::action_icon', function(action, _, hints)
	local path =
		utils.lookup_icon(
			hints.app_icon,
			naughty.config.icon_dirs
		) or utils.lookup_icon(hints.app_icon:lower(), naughty.config.icon_dirs)
	if path then
		action.icon = path
	end
end)

-- ===================================================================
-- Error Handling
-- ===================================================================

if awesome.startup_errors then
	naughty.notification({
		preset = naughty.config.presets.critical,
		title = 'Oops, there were errors during startup!',
		text = awesome.startup_errors,
	})
end

do
	local in_error = false
	awesome.connect_signal('debug::error', function(err)
		if in_error then return end
		in_error = true

		naughty.notification({
			preset = naughty.config.presets.critical,
			title = 'Oops, an error happened!',
			text = tostring(err),
		})
		in_error = false
	end)
end

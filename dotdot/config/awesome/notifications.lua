local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utils")

-- ===================================================================
-- Theme Definitions
-- ===================================================================

-- These are no-clear settings: cannot set the entire table at once
local defaults = {
	ontop = true,
	icon_size = dpi(24),
	timeout = 5,
	title = "Notification",
	margin = dpi(10),
	position = "top_right",
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
		timeout = 2,
	},
	critical = {
		font = beautiful.title_font,
		fg = "#ffffff",
		bg = "#ff0000",
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
naughty.config.icon_dirs = {
	"/usr/share/icons/breeze-dark/actions/",
	"/usr/share/icons/breeze-dark/animations/",
	"/usr/share/icons/breeze-dark/apps/",
	"/usr/share/icons/breeze-dark/categories/",
	"/usr/share/icons/breeze-dark/devices/",
	"/usr/share/icons/breeze-dark/emblems/",
	"/usr/share/icons/breeze-dark/mimetypes/",
	"/usr/share/icons/breeze-dark/notifications/",
	"/usr/share/icons/breeze-dark/panel/",
	"/usr/share/icons/breeze-dark/places/",
	"/usr/share/icons/breeze-dark/status/",
}

local function handle_brave_apps(args)
	local brave_apps = { "web.whatsapp.com", "www.instagram.com", "discord.com", "open.spotify.com" }

	for _, app in ipairs(brave_apps) do
		local app_pattern = "^" .. app .. "\n\n"
		local app_name = string.match(args.message or "", app_pattern)
		if app_name ~= nil then
			args.message = string.gsub(args.message, app_pattern, "")
			args.app_name = string.gsub(app_name, "%s+", "")
			args.actions = nil
			args.timeout = nil
			return args
		end
	end
	return args
end

naughty.config.notify_callback = function(args)
	args.screen = awful.screen.focused()
	-- args = handle_brave_apps(args)
	if args.actions ~= nil and #args.actions > 0 then
		args.timeout = 0.0
		args.ignore_suspend = true
	end
	return args
end

local function get_bounds(notif, args)
	local width = args.max_width
		or notif.max_width
		or (args.preset and args.preset.max_width)
		or (notif.preset and notif.preset.max_width)
		or nil
	local height = args.max_height
		or notif.max_height
		or (args.preset and args.preset.max_height)
		or (notif.preset and notif.preset.max_height)
		or nil
	local forced_width = args.width
		or notif.width
		or (args.preset and args.preset.width)
		or (notif.preset and notif.preset.width)
		or nil
	local forced_height = args.height
		or notif.height
		or (args.preset and args.preset.height)
		or (notif.preset and notif.preset.height)
		or nil
	return {
		width = width,
		height = height,
		forced_width = forced_width,
		forced_height = forced_height,
	}
end

naughty.connect_signal("request::display", function(notif, _, args)
	local bounds = get_bounds(notif, args)
	naughty.layout.box({
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
									font = "Inter Black 13",
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
					margins = defaults.margin,
				},
				id = "background_role",
				widget = naughty.container.background,
			},
			widget = wibox.container.constraint,
			width = bounds.width,
			height = bounds.height,
			forced_width = bounds.forced_width,
			forced_height = bounds.forced_height,
		},
		shape = defaults.shape,
	})
end)

naughty.connect_signal("request::icon", function(notif, context, hints)
	if context ~= "app_icon" then
		return
	end

	local path = utils.lookup_icon(hints.app_icon, naughty.config.icon_dirs)
		or utils.lookup_icon(hints.app_icon:lower(), naughty.config.icon_dirs)
	if path then
		notif.icon = path
	end
end)

naughty.connect_signal("request::action_icon", function(action, _, hints)
	local path = utils.lookup_icon(hints.app_icon, naughty.config.icon_dirs)
		or utils.lookup_icon(hints.app_icon:lower(), naughty.config.icon_dirs)
	if path then
		action.icon = path
	end
end)

naughty.connect_signal("destroyed", function(n, reason)
	if not n.clients then
		return
	end
	if reason == require("naughty.constants").notification_closed_reason.dismissed_by_user then
		if #n.clients == 1 then
			n.clients[1]:jump_to()
		else
			local pattern = string.lower(n.app_name)
			for _, c in ipairs(n.clients) do
				if string.find(string.lower(c.instance), pattern) then
					c:jump_to()
					return
				end
			end
		end
	end
end)

-- ===================================================================
-- Error Handling
-- ===================================================================

if awesome.startup_errors then
	naughty.notification({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end
		in_error = true

		naughty.notification({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end

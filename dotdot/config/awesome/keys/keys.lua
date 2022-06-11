local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local my_table = gears.table
local hotkeys_popup = require("awful.hotkeys_popup").widget

local modkey = "Mod4"
local altkey = "Mod1"
local ctrl = "Control"
local keys = {}

-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================

-- Move given client to given direction
local function move_client(c, direction)
	-- If client is floating, move to edge
	if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
		local workarea = awful.screen.focused().workarea
		if direction == "up" then
			c:geometry({
				nil,
				y = workarea.y + beautiful.useless_gap * 2,
				nil,
				nil,
			})
		elseif direction == "down" then
			c:geometry({
				nil,
				y = workarea.height
					+ workarea.y
					- c:geometry().height
					- beautiful.useless_gap * 2
					- beautiful.border_width * 2,
				nil,
				nil,
			})
		elseif direction == "left" then
			c:geometry({
				x = workarea.x + beautiful.useless_gap * 2,
				nil,
				nil,
				nil,
			})
		elseif direction == "right" then
			c:geometry({
				x = workarea.width
					+ workarea.x
					- c:geometry().width
					- beautiful.useless_gap * 2
					- beautiful.border_width * 2,
				nil,
				nil,
				nil,
			})
		end
		-- Otherwise swap the client in the tiled layout
	elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
		if direction == "up" or direction == "left" then
			awful.client.swap.byidx(-1, c)
		elseif direction == "down" or direction == "right" then
			awful.client.swap.byidx(1, c)
		end
	else
		awful.client.swap.global_bydirection(direction, c, nil)
	end
end

-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
	if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
		if direction == "up" then
			c:relative_move(0, 0, 0, -floating_resize_amount)
		elseif direction == "down" then
			c:relative_move(0, 0, 0, floating_resize_amount)
		elseif direction == "left" then
			c:relative_move(0, 0, -floating_resize_amount, 0)
		elseif direction == "right" then
			c:relative_move(0, 0, floating_resize_amount, 0)
		end
	else
		if direction == "up" then
			awful.client.incwfact(-tiling_resize_factor)
		elseif direction == "down" then
			awful.client.incwfact(tiling_resize_factor)
		elseif direction == "left" then
			awful.tag.incmwfact(-tiling_resize_factor)
		elseif direction == "right" then
			awful.tag.incmwfact(tiling_resize_factor)
		end
	end
end

-- raise focused client
local function raise_client()
	if client.focus then
		client.focus:raise()
	end
end

-- Toggle sticky floating window
local function sticky_float(c)
	awful.client.floating.toggle()
	if c.floating then
		c.ontop = true
		c.sticky = true
		c.width = 533
		c.height = 300
		awful.placement.top_right(client.focus)
	else
		c.ontop = false
		c.sticky = false
	end
end

-- ===================================================================
-- Mouse bindings
-- ===================================================================

-- Mouse buttons on the desktop
keys.desktopbuttons = my_table.join(
	-- left click on desktop to hide notification
	awful.button({}, 1, function()
		naughty.destroy_all_notifications(nil, 1000)
	end)
)

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(
	-- Raise client
	awful.button({}, 1, function(c)
		c:activate({
			switch_to_tag = true,
			raise = true,
		})
	end),
	-- Move and Resize Client
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

awful.util.taglist_buttons = my_table.join(awful.button({}, 1, function(t)
	t:view_only()
end))

awful.util.tasklist_buttons = my_table.join(
	--c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

	-- Without this, the following
	-- :isvisible() makes no sense
	-- This will also un-minimize
	-- the client, if needed
	awful.button({}, 1, function(c)
		if c == client.focus and c ~= awful.screen.focused():get_clients()[1] then
			c:raise()
		elseif c == client.focus then
			c.minimized = true
		else
			c:activate({
				switch_to_tag = true,
				raise = true,
			})
		end
	end)
)

-- ===================================================================
-- Desktop Key bindings
-- ===================================================================

keys.globalkeys = my_table.join(
	-- =========================================
	-- RELOAD / QUIT AWESOME
	-- =========================================

	-- Reload Awesome
	awful.key({ modkey, "Shift" }, "r", awesome.restart, {
		description = "reload awesome",
		group = "awesome",
	}),
	-- Toggle notifications
	awful.key({ modkey, ctrl }, "n", function()
		naughty.destroy_all_notifications()
		naughty.notification({
			title = "Info",
			message = (naughty.suspended and "Resuming" or "Suspending") .. " notifications",
			ignore_suspend = true,
		})
		naughty.suspended = not naughty.suspended
	end, {
		description = "toggle notifications",
		group = "awesome",
	}),
	-- Terminal (emergency)
	awful.key({ ctrl, altkey }, "t", function()
		awful.spawn(awful.util.terminal_alt)
	end, {
		description = "terminal",
		group = "awesome",
	}),
	-- Quit Awesome
	awful.key({ modkey, "Shift" }, "e", awesome.quit, {
		description = "quit awesome",
		group = "awesome",
	}),
	-- Show help
	awful.key({ modkey }, "s", hotkeys_popup.show_help, {
		description = "show help",
		group = "awesome",
	}),
	-- =========================================
	-- CLIENT FOCUSING
	-- =========================================
	-- Focus client by direction (arrow keys)
	awful.key({ modkey }, "Down", function()
		awful.client.focus.global_bydirection("down", client.focused, true)
		raise_client()
	end, {
		description = "focus down",
		group = "client",
	}),
	awful.key({ modkey }, "Up", function()
		awful.client.focus.global_bydirection("up", client.focused, true)
		raise_client()
	end, {
		description = "focus up",
		group = "client",
	}),
	awful.key({ modkey }, "Left", function()
		awful.client.focus.global_bydirection("left", client.focused, true)
		raise_client()
	end, {
		description = "focus left",
		group = "client",
	}),
	awful.key({ modkey }, "Right", function()
		awful.client.focus.global_bydirection("right", client.focused, true)
		raise_client()
	end, {
		description = "focus right",
		group = "client",
	}),
	awful.key({ modkey, altkey }, "Down", function()
		awful.client.focus.byidx(-1)
		raise_client()
	end, {
		description = "focus previous idx",
		group = "client",
	}),
	awful.key({ modkey, altkey }, "Up", function()
		awful.client.focus.byidx(1)
		raise_client()
	end, {
		description = "focus next idx",
		group = "client",
	}),
	awful.key({ modkey, altkey }, "Left", function()
		awful.client.focus.byidx(-1)
		raise_client()
	end, {
		description = "focus previous idx",
		group = "client",
	}),
	awful.key({ modkey, altkey }, "Right", function()
		awful.client.focus.byidx(1)
		raise_client()
	end, {
		description = "focus next idx",
		group = "client",
	}),
	awful.key({ modkey, altkey, "Ctrl" }, "Left", function()
		awful.screen.focus_bydirection("left", awful.screen.focused())
	end, {
		description = "focus left",
		group = "screen",
	}),
	awful.key({ modkey, altkey, "Ctrl" }, "Right", function()
		awful.screen.focus_bydirection("right", awful.screen.focused())
	end, {
		description = "focus right",
		group = "screen",
	}),
	awful.key({ modkey, altkey, "Ctrl" }, "Up", function()
		awful.screen.focus_bydirection("up", awful.screen.focused())
	end, {
		description = "focus up",
		group = "screen",
	}),
	awful.key({ modkey, altkey, "Ctrl" }, "Down", function()
		awful.screen.focus_bydirection("down", awful.screen.focused())
	end, {
		description = "focus down",
		group = "screen",
	}),

	-- Focus client by index (history)
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
		description = "jump to urgent client",
		group = "client",
	}),
	awful.key({ modkey }, "'", awful.tag.history.restore, {
		description = "go back",
		group = "tag",
	}),
	awful.key({ modkey }, "o", function()
		awful.screen.focus_relative(1)
	end, {
		description = "jump to other screen",
		group = "awesome",
	}),
	-- Show/Hide Wibox
	awful.key({ modkey, "Shift" }, "b", function()
		s = awful.screen.focused()
		s.mywibox.visible = not s.mywibox.visible
	end, {
		description = "toggle top wibar",
		group = "awesome",
	}),
	-- =========================================
	-- NUMBER OF MASTER / COLUMN CLIENTS
	-- =========================================

	-- Number of master clients
	awful.key({ modkey, altkey }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, {
		description = "increase the number of master clients",
		group = "layout",
	}),
	awful.key({ modkey, altkey }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, {
		description = "decrease the number of master clients",
		group = "layout",
	}),
	-- Number of columns
	awful.key({ modkey, altkey }, "k", function()
		awful.tag.incncol(1, nil, true)
	end, {
		description = "increase the number of columns",
		group = "layout",
	}),
	awful.key({ modkey, altkey }, "j", function()
		awful.tag.incncol(-1, nil, true)
	end, {
		description = "decrease the number of columns",
		group = "layout",
	}),
	-- =========================================
	-- GAP CONTROL
	-- =========================================

	-- Gap control
	awful.key({ modkey, "Shift" }, "minus", function()
		awful.tag.incgap(5, nil)
	end, {
		description = "increment gaps size for the current tag",
		group = "gaps",
	}),
	awful.key({ modkey }, "minus", function()
		awful.tag.incgap(-5, nil)
	end, {
		description = "decrement gap size for the current tag",
		group = "gaps",
	}),
	-- =========================================
	-- LAYOUT SELECTION
	-- =========================================

	-- select next layout
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, {
		description = "select next",
		group = "layout",
	}),
	-- select previous layout
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, {
		description = "select previous",
		group = "layout",
	}),
	-- =========================================
	-- CLIENT MINIMIZATION
	-- =========================================

	-- restore minimized client
	awful.key({ modkey, "Shift" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate({ raise = true })
		end
	end, {
		description = "restore minimized",
		group = "client",
	}),
	-- Copy primary to clipboard (terminals to gtk)
	awful.key({ modkey, "Shift" }, "c", function()
		awful.spawn.with_shell("xsel | xsel -i -b")
	end, {
		description = "copy terminal to gtk",
		group = "hotkeys",
	}),
	-- Copy clipboard to primary (gtk to terminals)
	awful.key({ modkey, "Shift" }, "v", function()
		awful.spawn.with_shell("xsel -b | xsel")
	end, {
		description = "copy gtk to terminal",
		group = "hotkeys",
	})
)

-- ===================================================================
-- Client Key bindings
-- ===================================================================

keys.clientkeys = gears.table.join(
	-- Maximize
	-- Move to edge or swap by direction
	awful.key({ modkey, "Shift" }, "o", function(c)
		c:move_to_screen()
	end),
	awful.key({ modkey, "Shift" }, "Down", function(c)
		move_client(c, "down")
	end),
	awful.key({ modkey, "Shift" }, "Up", function(c)
		move_client(c, "up")
	end),
	awful.key({ modkey, "Shift" }, "Left", function(c)
		move_client(c, "left")
	end),
	awful.key({ modkey, "Shift" }, "Right", function(c)
		move_client(c, "right")
	end),
	-- CLIENT RESIZING
	awful.key({ modkey, ctrl }, "Down", function(c)
		resize_client(c, "down")
	end),
	awful.key({ modkey, ctrl }, "Up", function(c)
		resize_client(c, "up")
	end),
	awful.key({ modkey, ctrl }, "Left", function(c)
		resize_client(c, "left")
	end),
	awful.key({ modkey, ctrl }, "Right", function(c)
		resize_client(c, "right")
	end),
	awful.key({ modkey, ctrl }, "space", awful.client.floating.toggle, {
		description = "toggle floating",
		group = "client",
	}),
	awful.key({ modkey, altkey }, "space", sticky_float, {
		description = "toggle sticky floating",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "c", awful.placement.centered, {
		description = "center floating client",
		group = "client",
	}),
	awful.key({ modkey, "Shift" }, "g", awful.rules.apply, {
		description = "reapply rules to client",
		group = "client",
	}),
	awful.key({ modkey, ctrl }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, {
		description = "move to master",
		group = "client",
	}),
	-- toggle fullscreen
	awful.key({ modkey, "Shift" }, "f", function(c)
		c.fullscreen = not c.fullscreen
	end, {
		description = "toggle fullscreen",
		group = "client",
	}),
	-- close client
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, {
		description = "close",
		group = "client",
	}),
	-- Minimize
	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, {
		description = "minimize",
		group = "client",
	}),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, {
		description = "(un)maximize",
		group = "client",
	})
)

-- Bind all key numbers to tags
for i = 1, 6 do
	keys.globalkeys = gears.table.join(
		keys.globalkeys,
		-- Switch to tag
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, {
			description = "view tag #" .. i,
			group = "tag",
		}),
		-- Move client to tag
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, {
			description = "move focused client to tag #" .. i,
			group = "tag",
		})
	)
end

return keys

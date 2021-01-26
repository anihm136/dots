local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os

local theme = {}
theme.dir = gears.filesystem.get_configuration_dir() .. "theme"
theme.wallpaper = function()
  local wall_dir = "~/Pictures/wallpapers/"
  local walls = io.popen("fd . "..wall_dir):lines()
  local iter_to_arr = function()
    local res = {}
    for line in walls do
      table.insert(res,line)
    end
    return res
  end
  walls = iter_to_arr(walls)
  math.randomseed(io.popen('od -vAn -N2 -d < /dev/urandom'):read('*a'))
  return walls[math.random(1,#walls)]
end
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

local markup = lain.util.markup

-- Textclock
local mytextclock = wibox.widget.textclock("<span> %I:%M:%S </span>", 1)
mytextclock.font = "Kimberley Bl 12"
mytextclock.forced_width = 78

-- Calendar
theme.cal =
  lain.widget.cal(
    {
      attach_to = {mytextclock},
      notification_preset = {
        title = "",
        icon_size = 110,
        margin = 5,
        font = "Overpass Mono 11",
        fg = theme.fg_normal,
        bg = theme.bg_normal
      }
    }
  )

-- /home fs
local fsicon = wibox.widget.imagebox(theme.disk)
local fsbar =
  wibox.widget {
    forced_height = dpi(1),
    forced_width = dpi(65),
    color = theme.fg_normal,
    background_color = theme.bg_normal,
    margins = 1,
    paddings = 1,
    ticks = true,
    ticks_size = dpi(6),
    widget = wibox.widget.progressbar
  }
theme.fs =
  lain.widget.fs {
    notification_preset = {fg = theme.fg_normal, bg = theme.bg_normal, font = "Overpass Mono 10.5"},
    settings = function()
      if fs_now["/"].percentage < 90 then
        fsbar:set_color(theme.fg_normal)
      else
        fsbar:set_color("#EB8F8F")
      end
      fsbar:set_value(fs_now["/"].percentage / 100)
    end
  }
local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, dpi(2), dpi(7), dpi(4), dpi(4))
--]]

-- Separators
local first = wibox.widget.textbox(markup.font("Overpass Mono 3", " "))
local spr = wibox.widget.textbox(" ")
local small_spr = wibox.widget.textbox(markup.font("Overpass Mono 4", " "))
local bar_spr =
  wibox.widget.textbox(
    markup.font("Overpass Mono 3", " ") ..
    markup.fontfg(theme.font, "#777777", "|") .. markup.font("Overpass Mono 5", " ")
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
  for i, tag in pairs(awful.util.tagnames_1) do
    awful.tag.add(
      tag,
      {
        -- icon = tag.icon,
        -- icon_only = true,
        layout = awful.layout.layouts[1],
        screen = s,
        selected = i == 1
      }
    )
  end

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist{screen=s, filter=awful.widget.taglist.filter.all, buttons=awful.util.taglist_buttons, style={font=theme.taglist_font}}

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist{screen=s, filter=awful.widget.tasklist.filter.currenttags, buttons=awful.util.tasklist_buttons, style={font=theme.font}}

  -- Create the wibox
  s.mywibox =
    awful.wibar({position = "top", screen = s, height = theme.menu_height, bg = theme.bg_normal, fg = theme.fg_normal})

  -- Add widgets to the wibox
  s.mywibox:setup {
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
      fsicon,
      fswidget,
      bar_spr,
      mytextclock
    }
  }
end

return theme

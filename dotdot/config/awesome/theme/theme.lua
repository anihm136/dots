local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os
local my_table = gears.table

local theme = {}
theme.dir = gears.filesystem.get_configuration_dir() .. "theme"
theme.wallpaper = function(s)
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
theme.font = "Overpass 13"
theme.fg_normal = "#BBBBBB"
theme.fg_focus = "#78A4FF"
theme.bg_normal = "#222222"
theme.bg_focus = "#222222"
theme.fg_urgent = "#000000"
theme.bg_urgent = "#FFFFFF"
theme.border_width = dpi(1)
theme.border_normal = "#111111"
theme.border_focus = "#93B6FF"
theme.taglist_fg_focus = "#FFFFFF"
theme.taglist_bg_focus = "#222222"
theme.taglist_bg_normal = "#222222"
theme.titlebar_bg_normal = "#191919"
theme.titlebar_bg_focus = "#262626"
theme.tooltip_bg = "#222222"
theme.tooltip_fg = "#BBBBBB"
theme.tooltip_font = "Overpass 8"
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.layout_centerfair = theme.dir .. "/icons/centerfair.png"
theme.layout_termfair = theme.dir .. "/icons/termfair.png"
theme.layout_centerwork = theme.dir .. "/icons/centerwork.png"
theme.useless_gap = 6
theme.tasklist_disable_icon = true

function theme.at_screen_connect(s)
    -- We need one layoutbox per screen.
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        my_table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    if s.index==1 then
        require('theme/screen_1').at_screen_connect(s)
    elseif s.index==2 then
        require('theme/screen_2').at_screen_connect(s)
    end
end

return theme

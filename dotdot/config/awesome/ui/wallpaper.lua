local bling = require('bling')

bling.module.wallpaper.setup {
    screens = screen,
    set_function = bling.module.wallpaper.setters.random,
    wallpaper = {os.getenv("HOME") .. "/Pictures/wallpapers"},
    change_timer = 631,
    position = "maximized",
}

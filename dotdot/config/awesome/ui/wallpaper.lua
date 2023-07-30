local bling = require("bling")

local screens = {}
for s in screen do
	table.insert(screens, s)
end

bling.module.wallpaper.setup({
	screen = screens,
	set_function = bling.module.wallpaper.setters.random,
	wallpaper = { os.getenv("HOME") .. "/Pictures/wallpapers/" },
	change_timer = 631,
	position = "maximized",
})

local awful = require("awful")
local apps = require("default_apps.apps")
for k, v in pairs(apps) do
	awful.util[k] = v
end

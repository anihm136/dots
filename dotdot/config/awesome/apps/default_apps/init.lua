local awful = require("awful")
local apps = require("apps.default_apps.apps")
for k, v in pairs(apps) do
	awful.util[k] = v
end

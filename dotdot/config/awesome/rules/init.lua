local keys = require("keys.keys")
local create_rules = require("rules.rules").create
local rules = create_rules(keys.clientkeys, keys.clientbuttons)
local ruled = require("ruled")
ruled.client.append_rules(rules)

local bling = require("bling")

local term_scratch = bling.module.scratchpad({
	command = "kitty --class term_scratch", -- How to spawn the scratchpad
	rule = { instance = "term_scratch" }, -- The rule that the scratchpad will be searched by
	sticky = true, -- Whether the scratchpad should be sticky
	autoclose = false, -- Whether it should hide itself when losing focus
	floating = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
	geometry = { x = 100, y = 100, height = 400, width = 600 }, -- The geometry in a floating state
	reapply = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
	dont_focus_before_close = true, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
})

return term_scratch

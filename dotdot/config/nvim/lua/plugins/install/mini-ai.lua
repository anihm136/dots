return {
	"echasnovski/mini.ai",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	event = "VeryLazy",
	config = function()
		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = {
				C = ai.gen_spec.treesitter({
					a = { "@function.outer", "@class.outer" },
					i = { "@function.inner", "@class.inner" },
				}),
				c = ai.gen_spec.treesitter({
					a = { "@conditional.outer", "@loop.outer" },
					i = { "@conditional.inner", "@loop.inner" },
				}),
			},
			mappings = {
				around_next = "",
				inside_next = "",
				around_last = "",
				inside_last = "",
				goto_left = "",
				goto_right = "",
			},
		})
	end,
}

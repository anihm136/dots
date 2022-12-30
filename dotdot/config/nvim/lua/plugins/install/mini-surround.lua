return {
	"echasnovski/mini.surround",
	event = "VeryLazy",
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "ys",
				delete = "ds",
				replace = "cs",
				highlight = "gsh",
				find = "gsf",
				find_left = "gsF",
				update_n_lines = "",
			},
			highlight_duration = 800,
		})
	end,
}

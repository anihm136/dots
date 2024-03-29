return {
	"echasnovski/mini.comment",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	event = "VeryLazy",
	config = function()
		require("mini.comment").setup({
			hooks = {
				pre = function()
					require("ts_context_commentstring").update_commentstring()
				end,
			},
		})
	end,
}

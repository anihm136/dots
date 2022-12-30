return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	build = ":TSUpdate",
	event = "BufReadPost",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			highlight = { enable = true },
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						af = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			},
			indent = { enable = false },
			context_commentstring = { enable = true, enable_autocmd = false },
			-- autotag = { enable = true },
			-- matchup = { enable = true },
		})
	end,
}

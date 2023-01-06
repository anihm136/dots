return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	build = ":TSUpdate",
	event = "BufReadPost",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			highlight = { enable = true },
			indent = { enable = false },
			context_commentstring = { enable = true, enable_autocmd = false },
			-- autotag = { enable = true },
			-- matchup = { enable = true },
		})
	end,
}

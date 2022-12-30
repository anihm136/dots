return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
		})
		vim.api.nvim_command("colorscheme catppuccin")
	end,
}

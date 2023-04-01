return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	config = function()
		require('catppuccin').setup({
			styles = {
				conditionals = {}
			},
			integrations = {
				notify = true,
				mini = true,
				mason = true,
				treesitter = true,
				dap = {
					enabled = true,
					enable_ui = true
				}
			}
		})
		vim.cmd.colorscheme 'catppuccin'
	end,
}

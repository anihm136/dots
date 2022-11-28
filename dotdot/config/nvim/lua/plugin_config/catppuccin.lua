return function()
	require("catppuccin").setup {
		flavour = "macchiato"
	}
	vim.api.nvim_command "colorscheme catppuccin"
end

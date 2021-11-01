return function()
	local map = vim.api.nvim_set_keymap
	local opts = {
		noremap = true,
		silent = true,
	}
	require"nvim-tree".setup()
	map("n", "<leader>0", "<cmd>NvimTreeToggle<cr>", opts)
end

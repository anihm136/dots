return function()
	local map = vim.api.nvim_set_keymap
	local opts = {
		noremap = true,
		silent = true,
	}
	map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
	map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
	map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
	map("n", "<C-;>", "<cmd>TmuxNavigateRight<cr>", opts)
	map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", opts)

end

return function()
	local map = vim.api.nvim_set_keymap
	local opts = {
		noremap = true,
		silent = true,
	}

	map('n', '<leader>ph', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
	map('n', '<leader>pa', '<cmd>lua require("harpoon.mark").add_file()<cr>', opts)
end

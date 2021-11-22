return function()
	local map = vim.api.nvim_buf_set_keymap
	vim.g.slime_no_mappings = 1
	vim.g.slime_target = "tmux"
	vim.g.slime_default_config = {
		socket_name = "default",
		target_pane = "{last}",
	}
	vim.g.slime_dont_ask_default = 1
	local opts = { silent = true }
	map(0, "n", "gr", "<Plug>SlimeMotionSend", opts)
	map(0, "x", "gr", "<Plug>SlimeRegionSend", opts)

end

return function()
	local map = vim.api.nvim_set_keymap
	local opts = { silent = true }
	map("n", "]q", "<Plug>(qf_qf_next)", opts)
	map("n", "[q", "<Plug>(qf_qf_previous)", opts)
	map("n", "]l", "<Plug>(qf_loc_next)", opts)
	map("n", "[l", "<Plug>(qf_loc_previous)", opts)
	map("n", "<F5>", "<Plug>(qf_qf_toggle_stay)", opts)
	map("n", "<F4>", "<Plug>(qf_loc_toggle_stay)", opts)
	map("n", "<F3>", "<Plug>(qf_qf_switch)", opts)
	vim.g.qf_mapping_ack_style = true
	vim.g.qf_auto_open_quickfix = false
	vim.g.qf_auto_open_loclist = false

end

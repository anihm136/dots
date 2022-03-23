return function()
	vim.g.vim_search_pulse_mode = "pattern"
	vim.g.vim_search_pulse_disable_auto_mappings = true
	local map = vim.api.nvim_set_keymap
	local opts = { silent = true }
	map("n", "*", "<Plug>(asterisk-z*)<Plug>(pulse)", opts)
	map("n", "#", "<Plug>(asterisk-z#)<Plug>(pulse)", opts)
	map("n", "g*", "<Plug>(asterisk-gz*)<Plug>(pulse)", opts)
	map("n", "g#", "<Plug>(asterisk-gz#)<Plug>(pulse)", opts)
	map("x", "*", "<Plug>(asterisk-z*)<Plug>(pulse)", opts)
	map("x", "#", "<Plug>(asterisk-z#)<Plug>(pulse)", opts)
	map("x", "g*", "<Plug>(asterisk-gz*)<Plug>(pulse)", opts)
	map("x", "g#", "<Plug>(asterisk-gz#)<Plug>(pulse)", opts)
	map("n", "n", "n<Plug>Pulse", opts)
	map("n", "N", "N<Plug>Pulse", opts)
end

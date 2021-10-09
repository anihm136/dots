return function()
	require('gitsigns').setup{
		keymaps = {
			-- Default keymap options
			noremap = true,
			buffer = true,
			['n ]c'] = {
				expr = true,
				"&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
			},
			['n [c'] = {
				expr = true,
				"&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
			},
			['n <leader>gl'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
		},
		watch_gitdir = { interval = 2000 },
		update_debounce = 500,
	}
end

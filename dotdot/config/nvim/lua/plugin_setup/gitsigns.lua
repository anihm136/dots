return function()
	require('gitsigns').setup{
		keymaps = {
			-- Default keymap options
			noremap = true,
			buffer = true,
			['n ]c'] = {
				expr = true,
				"&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'",
			},
			['n [c'] = {
				expr = true,
				"&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'",
			},
			['n <leader>gl'] = '<cmd>lua require"gitsigns".blame_line(true)<cr>',
		},
		watch_gitdir = { interval = 2000 },
		update_debounce = 500,
	}
end

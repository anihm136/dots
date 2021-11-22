return function()
	require'hop'.setup()
	local map = vim.api.nvim_set_keymap
	local opts = { noremap = true, silent = true }
	local lua = function(cmd)
		return '<cmd>lua '..cmd..'<cr>'
	end
	map('n', 'gsw', lua [[require'hop'.hint_words()]], opts)
	map('n', 'gsj', lua [[require'hop'.hint_lines()]], opts)
	map('x', 'gsw', lua [[require'hop'.hint_words()]], opts)
	map('x', 'gsj', lua [[require'hop'.hint_lines()]], opts)
end

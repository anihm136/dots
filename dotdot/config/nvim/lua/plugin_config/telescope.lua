return function()
	local map = vim.api.nvim_set_keymap
	local opts = {
		noremap = true,
		silent = true,
	}
	local lua = function(cmd)
		return "<cmd>lua " .. cmd .. "<cr>"
	end
	map(
		"n",
		"<leader>pf",
		lua[[require('telescope_config').file_search()]],
		opts
	)
	map(
		"n",
		"<leader><space>",
		lua[[require('telescope_config').file_search()]],
		opts
	)
	map(
		"n",
		"<leader>ff",
		lua[[require('telescope_config').file_search(vim.fn.expand("%:p:h"))]],
		opts
	)
	map(
		"n",
		"<leader>.",
		lua[[require('telescope_config').file_search(vim.fn.expand("%:p:h"))]],
		opts
	)
	map(
		"n",
		"<leader>fp",
		lua[[require('telescope_config').edit_dotfiles()]],
		opts
	)
	map("n", "<leader>fr", lua[[require('telescope_config').recent()]], opts)
	map("n", "<leader>sp", lua[[require('telescope_config').live_grep()]], opts)
	map(
		"n",
		"<leader>sd",
		lua[[require('telescope_config').live_grep(vim.fn.expand("%:p:h"))]],
		opts
	)
	map(
		"n",
		"<leader>rw",
		lua[[require('telescope_config').grep_prompt()]],
		opts
	)
	map("n", "<leader>,", lua[[require('telescope_config').buffers()]], opts)
	map("n", "<leader>bb", lua[[require('telescope_config').buffers()]], opts)
	map("n", "<leader>sb", lua[[require('telescope_config').curbuf()]], opts)
	map("n", "<leader>fh", lua[[require('telescope_config').help_tags()]], opts)
	map(
		"n",
		"<leader>ss",
		lua[[require('session-lens').search_session()]],
		opts
	)
	map("n", "<leader>:", lua[[require('telescope_config').commands()]], opts)
	map(
		"n",
		"g0",
		lua[[require('telescope_config').lsp_document_symbols()]],
		opts
	)
	map(
		"n",
		"gW",
		lua[[require('telescope_config').lsp_workspace_symbols()]],
		opts
	)

end

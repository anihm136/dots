return function()
	require'nvim-treesitter.configs'.setup{
		ensure_installed = 'all',
		highlight = { enable = true },
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					af = '@function.outer',
					['if'] = '@function.inner',
					ac = '@class.outer',
					ic = '@class.inner',
				},
			},
		},
		indent = { enable = false },
		context_commentstring = { enable = true },
		-- autotag = { enable = true },
		-- matchup = { enable = true },
	}

end

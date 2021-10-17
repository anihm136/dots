return function()
	require'nvim-treesitter.configs'.setup{
		ensure_installed = 'maintained',
		highlight = { enable = true },
		textobjects = {
			swap = {
				enable = true,
				swap_next = { ['g>'] = '@parameter.inner' },
				swap_previous = { ['g<'] = '@parameter.inner' },
			},
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
		autotag = { enable = true },
		matchup = { enable = true },
		textsubjects = {
			enable = true,
			keymaps = {
				['.'] = 'textsubjects-smart',
				[';'] = 'textsubjects-container-outer',
			},
		},
	}

end

return function()
	require'nvim-treesitter.configs'.setup{
		ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		highlight = { enable = true }, -- false will disable the whole extension
		textobjects = {
			swap = {
				enable = true,
				swap_next = { ['g>'] = '@parameter.inner' },
				swap_previous = { ['g<'] = '@parameter.inner' },
			},
			select = {
				enable = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					af = '@function.outer',
					['if'] = '@function.inner',
					ac = '@class.outer',
					ic = '@class.inner',
				},
			},
		},
		indent = { enable = false },
		context_commentstring = { enable = true },
	}
end

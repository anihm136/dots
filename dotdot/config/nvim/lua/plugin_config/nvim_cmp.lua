return function()
	local cmp = require'cmp'
	local lspkind = require'lspkind'
	local helpers = require'helpers'

	cmp.setup({
		snippet = { expand = function(args)
			require'snippy'.expand_snippet(args.body)
		end },
		mapping = {
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<Tab>'] = cmp.mapping(helpers.smart_tab, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(helpers.smart_backtab, { 'i', 's' }),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
			{ name = 'snippy' },
		},
		completion = { autocomplete = false },
		formatting = { format = lspkind.cmp_format() },
	})
end

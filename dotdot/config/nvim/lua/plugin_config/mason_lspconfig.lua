return function()
	require("mason-lspconfig").setup({
		ensure_installed = { "sumneko_lua", "gopls", "pyright", "clangd" }
	})
end

return function()
	local l = require("lspconfig")
	l.sumneko_lua.setup {}
	l.gopls.setup {}
	l.pyright.setup {}
	l.clangd.setup {}
end

return function(client, bufnr)
	client.server_capabilities.document_formatting = false
	local function map(modes, lhs, rhs, desc)
		local opts = {
			noremap = true,
			silent = true,
			buffer = bufnr,
			desc = desc,
		}
		vim.keymap.set(modes, lhs, rhs, opts)
	end

	-- Mappings.
	map("n", "<leader>cD", vim.lsp.buf.declaration, "Jump to declaration")
	map("n", "<leader>cd", vim.lsp.buf.definition, "Jump to definition")
	map("n", "<leader>ch", vim.lsp.buf.hover, "Show hover information")
	map("n", "<leader>ci", vim.lsp.buf.implementation, "Jump to implementation")
	map("n", "<leader>cs", vim.lsp.buf.signature_help, "Show function signature help")
	map("i", "<C-s>", vim.lsp.buf.signature_help, "Show function signature help")
	map("n", "<leader>ct", vim.lsp.buf.type_definition, "Jump to type definition")
	map("n", "<leader>cn", vim.lsp.buf.rename, "Rename")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Show code actions")
	map("n", "<leader>cr", vim.lsp.buf.references, "Show references")
	map("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, "Format")
end

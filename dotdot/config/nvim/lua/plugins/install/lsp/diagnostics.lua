vim.diagnostic.config({
	underline = true,
	virtual_text = { spacing = 4, prefix = "● ", source = true },
	float = {
		source = true,
	},
	severity_sort = true,
})

local diagnostic_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(diagnostic_signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local function map(modes, lhs, rhs, desc)
	local opts = {
		noremap = true,
		silent = true,
		desc = desc,
	}
	vim.keymap.set(modes, lhs, rhs, opts)
end

map("n", "[e", vim.diagnostic.goto_prev, "Next diagnostic")
map("n", "]e", vim.diagnostic.goto_next, "Prev diagnostic")
map("n", "<leader>ce", vim.diagnostic.setloclist, "Add diagnostics to loclist")
map("n", "<leader>cl", vim.diagnostic.open_float, "Diagnostic details")

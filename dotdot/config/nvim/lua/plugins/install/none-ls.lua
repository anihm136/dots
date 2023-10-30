return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	event = "VeryLazy",
	config = function()
		local n = require("null-ls")
		n.setup({
			sources = {
				-- Python
				n.builtins.diagnostics.ruff,
				n.builtins.diagnostics.mypy.with({
					extra_args={"--ignore-missing-imports"}
				}),
				n.builtins.formatting.black,
				n.builtins.formatting.ruff,

				-- Go
				n.builtins.diagnostics.golangci_lint,
				n.builtins.formatting.gofmt,

				-- C(pp)
				n.builtins.formatting.clang_format.with({
					extra_args = { "--style=file" },
				}),

				-- JS
				n.builtins.formatting.prettierd,
				n.builtins.diagnostics.eslint_d,
				n.builtins.formatting.eslint_d,

				-- Sh
				n.builtins.diagnostics.zsh,
				n.builtins.formatting.shfmt.with({
					extra_filetypes = { "bash" },
				}),
				n.builtins.diagnostics.shellcheck.with({
					extra_filetypes = { "bash" },
				}),

				-- Haskell
				n.builtins.formatting.fourmolu,

				-- Lua
				n.builtins.formatting.stylua,

				-- Terraform
				n.builtins.formatting.terraform_fmt.with({
					filetypes = { "terraform", "tf", "hcl" },
				}),
			},
		})

		require("mason-null-ls").setup({
			automatic_installation = true,
		})
	end,
}

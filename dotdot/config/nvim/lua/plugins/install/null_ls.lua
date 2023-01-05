return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim",
	"jay-babu/mason-null-ls.nvim",
},
	config = function()
		local n = require("null-ls")
		n.setup({
			sources = {
				-- Python
				-- n.builtins.diagnostics.flake8,
				n.builtins.formatting.black,
				n.builtins.formatting.isort.with({
					extra_args = { "--profile", "black" },
				}),

				-- Go
				n.builtins.diagnostics.golangci_lint,
				n.builtins.formatting.gofmt,

				-- C(pp)
				n.builtins.formatting.clang_format.with({
					extra_args = { "--style=file" },
				}),

				-- JS
				-- n.builtins.formatting.prettierd,
				-- n.builtins.diagnostics.eslint_d,
				-- n.builtins.formatting.eslint_d,

				-- Sh
				n.builtins.diagnostics.zsh,
				n.builtins.formatting.shfmt.with({
					extra_filetypes = { "bash" },
				}),
				n.builtins.diagnostics.shellcheck.with({
					extra_filetypes = { "bash" },
				}),

				-- Haskell
				-- n.builtins.formatting.fourmolu,

				-- Lua
				n.builtins.formatting.stylua,
			},
		})

		require("mason-null-ls").setup({
			automatic_installation = true,
		})
	end,
}

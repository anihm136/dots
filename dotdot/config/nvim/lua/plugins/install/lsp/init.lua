return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = "BufReadPre",
	config = function()
		require("plugins.install.lsp.diagnostics")
		require("plugins.install.lsp.handlers")

		require("mason").setup{
			PATH = "append",
			pip = {
				upgrade_pip = true
			}
		}

		local lsp_configs = require("plugins.install.lsp.server_config")
		require("mason-lspconfig").setup({
			automatic_installation = true
		})

		local l = require("lspconfig")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local options = {
			on_attach = function(client, bufnr)
				require("plugins.install.lsp.keybindings")(client, bufnr)
			end,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		}

		for server, config in pairs(lsp_configs) do
			config = vim.tbl_deep_extend("force", {}, options, config or {})
			l[server].setup(config)
		end
	end,
}

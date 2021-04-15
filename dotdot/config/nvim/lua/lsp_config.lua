local lsp = require("lspconfig")
require"lspinstall".setup()
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")

if vim.env.SNIPPETS then
	vim.snippet = require"snippet"
end

vim.lsp.set_log_level("trace")

local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, result, {
		noremap = true,
		silent = true,
	})
end

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
	if err ~= nil or result == nil then return end
	if not vim.api.nvim_buf_get_option(bufnr, "modified") then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, bufnr)
		vim.fn.winrestview(view)
		if bufnr == vim.api.nvim_get_current_buf() then
			vim.cmd[[noautocmd :update]]
		end
	end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		virtual_text = {
			spacing = 5,
			prefix = " ",
		},
		signs = function(bufnr, client_id)
			local ok, result =
				pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
			-- No buffer local variable set, so just enable by default
			if not ok then
				return true
			end

			return result
		end,
		update_in_insert = false,
	}
)

local on_attach = function(client)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	mapper("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	mapper("n", "<leader>cD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	mapper("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>")
	mapper("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	mapper("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	mapper("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	mapper("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	mapper("n", "<leader>ce", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
	mapper("n", "<leader>cf", "<cmd>lua helpers.formatting()<CR>")
	mapper(
		"n",
		"<space>sl",
		"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
	)
	client.resolved_capabilities.document_formatting = false
end

local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

-- lsp-install
local function setup_servers()
	require"lspinstall".setup()

	-- get all installed servers
	local servers = require"lspinstall".installed_servers()

	for _, server in pairs(servers) do
		if server ~= "efm" then
			local config = make_config()

			if server == "cpp" then
				config.filetypes = { "c", "cpp" }

				config.init_options = {
					usePlaceholders = true,
					completeUnimported = true,
				}
			end
			if server == "bash" then
				config.filetypes = { "sh", "bash", "zsh" }
				config.root_dir = function(filename, bufnr)
					return "/tmp"
				end
			end
			if server == "python" then
				config.root_dir = function(fname)
					local filename =
						util.path.is_absolute(
							fname
						) and fname or util.path.join(vim.loop.cwd(), fname)
					local root_pattern =
						util.root_pattern(
							"setup.py",
							"setup.cfg",
							"requirements.txt",
							"mypy.ini",
							".pylintrc",
							".flake8rc",
							".git",
							".gitignore"
						)
					return root_pattern(filename) or util.path.dirname(filename)
				end
			end
			if server == "go" then
				config.root_dir = function(fname)
					local filename =
						util.path.is_absolute(
							fname
						) and fname or util.path.join(vim.loop.cwd(), fname)
					local root_pattern = util.root_pattern("go.mod", ".git")
					return root_pattern(filename) or util.path.dirname(filename)
				end
			end

			require"lspconfig"[server].setup(config)
		end
	end
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require"lspinstall".post_install_hook = function()
	setup_servers() -- reload installed servers
end

-- lsp.intelephense.setup{
-- 	on_attach = function(client)
-- 		client.resolved_capabilities.document_formatting = false
-- 		on_attach(client)
-- 	end,
-- 	capabilities = {
-- 		textDocument = {
-- 			completion = {
-- 				completionItem = { snippetSupport = true },
-- 			},
-- 		},
-- 	},
-- 	init_options = {
-- 		usePlaceholders = true,
-- 		completeUnimported = true,
-- 	},
-- }

local clangformat = require"efm/clangformat"
local golint = require"efm/golint"
local gofmt = require"efm/gofmt"
local goimports = require"efm/goimports"
local black = require"efm/black"
local isort = require"efm/isort"
local flake8 = require"efm/flake8"
local pylint = require"efm/pylint"
local prettier = require"efm/prettier"
local eslint = require"efm/eslint"
local shellcheck = require"efm/shellcheck"
local format_options_prettier = {
	tabWidth = 4,
	singleQuote = true,
	trailingComma = "all",
	configPrecedence = "prefer-file",
}
vim.g.format_options_typescript = format_options_prettier
vim.g.format_options_javascript = format_options_prettier
vim.g.format_options_typescriptreact = format_options_prettier
vim.g.format_options_javascriptreact = format_options_prettier
vim.g.format_options_json = format_options_prettier
vim.g.format_options_css = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_markdown = format_options_prettier
vim.g.format_options_lua = format_options_prettier

lsp.efm.setup{
	on_attach = on_attach,
	init_options = { documentFormatting = true },
	filetypes = {
		"lua",
		"c",
		"cpp",
		"go",
		"python",
		"typescript",
		"javascript",
		"typescriptreact",
		"javascriptreact",
		"yaml",
		"json",
		"html",
		"scss",
		"css",
		"markdown",
		"sh",
	},
	root_dir = function(fname)
		local filename =
			util.path.is_absolute(fname) and fname or util.path.join(
				vim.loop.cwd(),
				fname
			)
		local root_pattern =
			util.root_pattern(
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"mypy.ini",
				".pylintrc",
				".flake8rc",
				"go.mod",
				"package.json",
				".git",
				".gitignore"
			)
		return root_pattern(filename) or util.path.dirname(filename)
	end,
	settings = {
		rootMarkers = {
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"mypy.ini",
			".pylintrc",
			".flake8rc",
			"go.mod",
			"package.json",
			".git",
			".gitignore",
		},
		languages = {
			lua = { prettier },
			c = { clangformat },
			cpp = { clangformat },
			go = { golint, goimports, gofmt },
			python = { black, isort, flake8, pylint },
			typescript = { prettier, eslint },
			javascript = { prettier, eslint },
			typescriptreact = { prettier, eslint },
			javascriptreact = { prettier, eslint },
			yaml = { prettier },
			json = { prettier },
			html = { prettier },
			scss = { prettier },
			css = { prettier },
			markdown = { prettier },
			sh = { shellcheck },
		},
	},
}

setup_servers()

local util = require("lspconfig/util")
local cmp_lsp = require("cmp_nvim_lsp")

vim.lsp.set_log_level("error")

local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, result, {
		noremap = true,
		silent = true,
	})
end

vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx)
	if err ~= nil then
		vim.cmd[[ echohl Error ]]
		vim.cmd([[ echomsg ']] .. tostring(err) .. [[']])
		vim.cmd[[ echohl None ]]
		-- print(err)
		return
	elseif result == nil then
		return
	end
	if not vim.api.nvim_buf_get_option(ctx.bufnr, "modified") then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, ctx.bufnr)
		vim.fn.winrestview(view)
		if ctx.bufnr == vim.api.nvim_get_current_buf() then
			vim.cmd[[noautocmd :update]]
		end
	end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		severity = vim.diagnostic.severity.ERROR,
		virtual_text = {
			spacing = 5,
			prefix = " ",
			source = "if_many",
		},
		signs = function(bufnr, _)
			local ok, result =
				pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
			-- No buffer local variable set, so just enable by default
			if not ok then
				return true
			end

			return result
		end,
		update_in_insert = false,
		severity_sort = true,
	}
)

vim.lsp.handlers["textDocument/hover"] =
	vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signature_help"] =
	vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

local on_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	mapper("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	mapper("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>")
	mapper("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>")
	mapper("n", "<leader>ce", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>")
	mapper("n", "<leader>cf", "<cmd>lua helpers.formatting()<cr>")
	mapper("n", "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<cr>")
	mapper("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>")
end

local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.codeLens = { dynamicRegistration = false }
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}
	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
		on_init = on_init,
	}
end

local function get_lua_runtime()
	local result = {}
	for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
		local lua_path = path .. "/lua/"
		if vim.fn.isdirectory(lua_path) then
			result[lua_path] = true
		end
	end

	result[vim.fn.expand("$VIMRUNTIME/lua")] = true

	result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

	return result
end

-- lsp-install
local function setup_servers()
	require"lspinstall".setup()

	-- get all installed servers
	local servers = require"lspinstall".installed_servers()

	for _, server in pairs(servers) do
		local config = make_config()

		if server == "cpp" then
			config.cmd =
				{
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--suggest-missing-includes",
					"--header-insertion=iwyu",
				}
			config.filetypes = { "c", "cpp" }

			config.init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			}
			local old_attach = config.on_attach
			config.on_attach = function(client)
				old_attach(client)
				client.resolved_capabilities.document_formatting = false
			end
		elseif server == "typescript" then
			local old_attach = config.on_attach
			config.on_attach = function(client)
				old_attach(client)
				client.resolved_capabilities.document_formatting = false
			end
		elseif server == "bash" then
			config.filetypes = { "sh", "bash", "zsh" }
			config.root_dir = function(_, _)
				return "/tmp"
			end
		elseif server == "python" then
			config.root_dir = function(fname)
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
						".git",
						".gitignore"
					)
				return root_pattern(filename) or util.path.dirname(filename)
			end
		elseif server == "go" then
			config.root_dir = function(fname)
				local filename =
					util.path.is_absolute(fname) and fname or util.path.join(
						vim.loop.cwd(),
						fname
					)
				local root_pattern = util.root_pattern("go.mod", ".git")
				return root_pattern(filename) or util.path.dirname(filename)
			end
			local old_attach = config.on_attach
			config.on_attach = function(client)
				old_attach(client)
				client.resolved_capabilities.document_formatting = false
			end
		elseif server == "lua" then
			config.root_dir = function(fname)
				return util.find_git_ancestor(fname) or util.path.dirname(fname)
			end
			config.settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					completion = { keywordSnippet = "Disable" },
					diagnostics = {
						enable = true,
						disable = config.disabled_diagnostics or {
							"trailing-space",
						},
						globals = vim.list_extend(
							{ -- Neovim
							"vim", "describe", "it", "before_each", "after_each", "teardown", "pending", "clear", "awesome" },
							config.globals or {}
						),
					},
					workspace = {
						library = vim.list_extend(
							get_lua_runtime(),
							config.library or {}
						),
						maxPreload = 1000,
						preloadFileSize = 1000,
					},
				},
			}
		elseif server == "efm" then
			local clangformat = require"efm/clangformat"
			local golint = require"efm/golint"
			local gofmt = require"efm/gofmt"
			local black = require"efm/black"
			local isort = require"efm/isort"
			local flake8 = require"efm/flake8"
			local pylint = require"efm/pylint"
			local prettier = require"efm/prettier"
			local eslint = require"efm/eslint"
			local shellcheck = require"efm/shellcheck"
			local shfmt = require"efm/shfmt"
			config.init_options = { documentFormatting = true }
			config.filetypes =
				{
					"lua",
					"c",
					"cpp",
					"go",
					"python",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"vue",
					"yaml",
					"json",
					"html",
					"scss",
					"css",
					"markdown",
					"sh",
					"bash",
					"zsh",
				}
			config.root_dir = function(fname)
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
			end
			config.settings = {
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
					go = { golint, gofmt },
					python = { black, isort, flake8, pylint },
					typescript = { prettier, eslint },
					javascript = { prettier, eslint },
					typescriptreact = { prettier, eslint },
					javascriptreact = { prettier, eslint },
					vue = { prettier, eslint },
					yaml = { prettier },
					json = { prettier },
					html = { prettier },
					scss = { prettier },
					css = { prettier },
					markdown = { prettier },
					sh = { shellcheck, shfmt },
					bash = { shellcheck, shfmt },
					zsh = { shellcheck },
				},
			}
		end

		require"lspconfig"[server].setup(
			vim.tbl_extend("force", config, {
				capabilities = cmp_lsp.update_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})
		)
	end
end

require"lspinstall".post_install_hook = function()
	setup_servers()
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
vim.g.format_options_vue = format_options_prettier
vim.g.format_options_json = format_options_prettier
vim.g.format_options_css = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_markdown = format_options_prettier
vim.g.format_options_lua = format_options_prettier

setup_servers()

local lsp = require("lspconfig")
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
end

local servers = { "tsserver", "cssls", "jsonls", "html", "gopls" }
for _, lsp_srv in ipairs(servers) do
	lsp[lsp_srv].setup{ on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		on_attach(client)
	end }
end

lsp.bashls.setup{
	on_attach = on_attach,
	filetypes = { "sh", "bash", "zsh" },
	root_dir = function(filename, bufnr)
		return "/tmp"
	end,
}

lsp.pyright.setup{
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		on_attach(client)
	end,
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
				".git",
				".gitignore"
			)
		return root_pattern(filename) or util.path.dirname(filename)
	end,
}

lsp.gopls.setup{
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		on_attach(client)
	end,
	root_dir = function(fname)
		local filename =
			util.path.is_absolute(fname) and fname or util.path.join(
				vim.loop.cwd(),
				fname
			)
		local root_pattern = util.root_pattern("go.mod", ".git")
		return root_pattern(filename) or util.path.dirname(filename)
	end,
}

lsp.clangd.setup{
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		on_attach(client)
	end,
	capabilities = {
		textDocument = {
			completion = {
				completionItem = { snippetSupport = true },
			},
		},
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
}

lsp.intelephense.setup{
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		on_attach(client)
	end,
	capabilities = {
		textDocument = {
			completion = {
				completionItem = { snippetSupport = true },
			},
		},
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
}

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

function LspRenameFloat()
	local current_word = vim.fn.expand("<cword>")
	local plenary_window =
		require("plenary.window.float").percentage_range_window(0.5, 0.2)
	vim.api.nvim_buf_set_option(plenary_window.bufnr, "buftype", "prompt")
	vim.fn.prompt_setprompt(
		plenary_window.bufnr,
		string.format('Rename "%s" to > ', current_word)
	)
	vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
		vim.api.nvim_win_close(plenary_window.win_id, true)

		if text ~= "" then
			vim.schedule(function()
				vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })

				vim.lsp.buf.rename(text)
			end)
		else
			print("Nothing to rename!")
		end
	end)

	vim.cmd[[startinsert]]
end
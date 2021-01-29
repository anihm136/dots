local lsp = require("lspconfig")
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")

if vim.env.SNIPPETS then
	vim.snippet = require"snippet"
end

vim.lsp.set_log_level("debug")

local mapper = function(mode, key, result)
	vim.api.nvim_buf_set_keymap(0, mode, key, result, {
		noremap = true,
		silent = true,
	})
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

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	mapper("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	mapper("n", "<leader>cD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	mapper("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>")
	mapper("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	mapper("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	mapper("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	mapper("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	mapper("n", "<leader>ce", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
	mapper(
		"n",
		"<space>sl",
		"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
	)
end

local servers = { "tsserver", "cssls", "jsonls", "html", "gopls" }
for _, lsp_srv in ipairs(servers) do
	lsp[lsp_srv].setup{ on_attach = on_attach }
end

lsp.bashls.setup{
	on_attach = on_attach,
	filetypes = { "sh", "bash", "zsh" },
	root_dir = function(filename, bufnr)
		return "/tmp"
	end,
}

lsp.pyright.setup{
	on_attach = on_attach,
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
	on_attach = on_attach,
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
	on_attach = on_attach,
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
	on_attach = on_attach,
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

-- lsp.diagnosticls.setup {
--     on_attach = on_attach,
--     filetypes = {
--         "javascript",
--         "javascript.jsx",
--         "javascriptreact",
--         "typescript",
--         "typescript.tsx",
--         "typescriptreact",
--         "python"
--     },
--     init_options = {
--         filetypes = {
--             ["javascript.jsx"] = "eslint",
--             ["typescript.tsx"] = "eslint",
--             javascript = "eslint",
--             javascriptreact = "eslint",
--             typescript = "eslint",
--             typescriptreact = "eslint",
--             python = {"pylint", "flake8"}
--         },
--         linters = {
--             eslint = {
--                 sourceName = "eslint",
--                 command = "eslint_d",
--                 rootPatterns = {
--                     ".eslintrc",
--                     ".eslintrc.json",
--                     ".eslintrc.cjs",
--                     ".eslintrc.js",
--                     ".eslintrc.yml",
--                     ".eslintrc.yaml",
--                     "package.json"
--                 },
--                 debounce = 100,
--                 args = {
--                     "--stdin",
--                     "--stdin-filename",
--                     "%filepath",
--                     "--format",
--                     "json"
--                 },
--                 parseJson = {
--                     errorsRoot = "[0].messages",
--                     line = "line",
--                     column = "column",
--                     endLine = "endLine",
--                     endColumn = "endColumn",
--                     message = "[${ruleId}] ${message}",
--                     security = "severity"
--                 },
--                 securities = {
--                     [2] = "error",
--                     [1] = "warning"
--                 },
--                 requiredFiles = {
--                     ".eslintrc",
--                     ".eslintrc.json",
--                     ".eslintrc.cjs",
--                     ".eslintrc.js",
--                     ".eslintrc.yml",
--                     ".eslintrc.yaml",
--                     "package.json"
--                 }
--             },
--             pylint = {
--                 sourceName = "pylint",
--                 command = "pylint",
--                 rootPatterns = {
--                     ".pylintrc",
--                     ".venv",
--                     "Pipfile",
--                     "requirements.txt",
--                     "pyproject.toml"
--                 },
--                 debounce = 100,
--                 args = {
--                     "-f",
--                     "json",
--                     "%filepath"
--                 },
--                 parseJson = {
--                     line = "line",
--                     column = "column",
--                     message = "[${message-id}] ${message}",
--                     security = "type"
--                 },
--                 securities = {
--                     error = "error",
--                     convention = "warning"
--                 },
--                 requiredFiles = {
--                     ".pylintrc",
--                     ".venv",
--                     "Pipfile",
--                     "requirements.txt",
--                     "pyproject.toml"
--                 }
--             },
--             flake8 = {
--                 sourceName = "flake8",
--                 command = "flake8",
--                 rootPatterns = {
--                     ".flake8",
--                     ".venv",
--                     "Pipfile",
--                     "requirements.txt",
--                     "pyproject.toml"
--                 },
--                 debounce = 100,
--                 args = {
--                     "--format",
--                     "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
--                     "%filepath"
--                 },
--                 formatLines = 1,
--                 formatPattern = {
--                     "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
--                     {
--                         line = 1,
--                         column = 2,
--                         message = {"[", 3, "] ", 5},
--                         security = 4
--                     }
--                 },
--                 securities = {
--                     error = {"E", "F"},
--                     warning = "W"
--                 },
--                 requiredFiles = {
--                     ".flake8",
--                     ".venv",
--                     "Pipfile",
--                     "requirements.txt",
--                     "pyproject.toml"
--                 }
--             }
--         }
--     }
-- }

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
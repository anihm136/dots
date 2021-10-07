RELOAD = require("plenary.reload").reload_module

R = function(name)
	RELOAD(name)
	return require(name)
end

P = function(v)
	print(vim.inspect(v))
	return v
end

function _G.lsp_reinstall_all()
	local lspinstall = require"lspinstall"
	for _, server in ipairs(lspinstall.installed_servers()) do
		lspinstall.install_server(server)
	end
end

getmetatable("").__index = function(str, i)
	if type(i) == "number" then
		return string.sub(str, i, i)
	else
		return string[i]
	end
end

require"gen_config"
require"lsp_config"
require"plugin_config"
require"dap_config"
_G.helpers = require("helpers")

vim.cmd[[
    command! -complete=file -nargs=* DebugC lua require "dap/gdb_config".start_c_debugger({<f-args>}, "gdb")
]]
vim.cmd[[
    command! -complete=file -nargs=* DebugRust lua require "dap/gdb_config".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]
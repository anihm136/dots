P = function(v)
	print(vim.inspect(v))
	return v
end

getmetatable("").__index = function(str, i)
	if type(i) == "number" then
		return string.sub(str, i, i)
	else
		return string[i]
	end
end

require"impatient".enable_profile()
require"packer_compiled"
require"gen_config"
require"lsp_config"
require"dap_config"
_G.helpers = require("helpers")

vim.cmd[[
    command! -complete=file -nargs=* DebugC lua require "dap/gdb_config".start_c_debugger({<f-args>}, "gdb")
]]
vim.cmd[[
    command! -complete=file -nargs=* DebugRust lua require "dap/gdb_config".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]

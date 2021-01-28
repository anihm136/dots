RELOAD = require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

require "gen_config"
require "lsp_config"
require "plugin_config"
require "dap_config"
helpers = require('helpers')

vim.cmd [[
    command! -complete=file -nargs=* DebugC lua require "dap/gdb_config".start_c_debugger({<f-args>}, "gdb")
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugRust lua require "dap/gdb_config".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]

local dap = require("dap")

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap.adapters.cpp = {
	type = "executable",
	attach = {
		pidProperty = "pid",
		pidSelect = "ask",
	},
	command = "lldb-vscode-10",
	env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
	name = "lldb",
}

dap.configurations.python = { {
	type = "python",
	request = "launch",
	name = "Launch file",
	program = "${file}",
	console = "integratedTerminal",
	pythonPath = function(adapter)
		local cwd = vim.fn.getcwd()
		print(vim.fn.executable(cwd .. "/venv/bin/python"))
		if vim.fn.executable(cwd .. "/venv/bin/python") ~= 0 then
			return cwd .. "/venv/bin/python"
		elseif vim.fn.executable(cwd .. "/.venv/bin/python") ~= 0 then
			return cwd .. "/.venv/bin/python"
		else
			return "/usr/bin/python"
		end
	end,
} }
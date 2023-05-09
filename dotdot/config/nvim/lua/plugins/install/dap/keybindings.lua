local function map(modes, lhs, rhs, desc)
	local opts = {
		noremap = true,
		silent = true,
		buffer = true,
		desc = desc,
	}
	vim.keymap.set(modes, lhs, rhs, opts)
end
local dap = require("dap")
local dapui = require("dapui")
map("n", "<leader>du", dapui.toggle, "Toggle DAP UI")
map("n", "<leader>ds", dap.continue, "Start/continue debugging")
map("n", "<leader>dt", dap.terminate, "Terminate debugging session")
map("n", "<leader>dh", dap.run_to_cursor, "Run until current cursor position")
map("n", "<leader>dn", dap.step_over, "Step over")
map("n", "<leader>dj", dap.step_into, "Step into")
map("n", "<leader>dk", dap.step_out, "Step out")
map("n", "<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
map("n", "<leader>dc", dap.clear_breakpoints, "Clear all breakpoints")
map("n", "<leader>dl", function()
	dap.toggle_breakpoint(nil, nil, vim.fn.input("Enter log message: "))
end, "Toggle log point")
map("n", "<leader>de", dapui.eval, "Evaluate symbol under cursor")

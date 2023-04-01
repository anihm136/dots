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
map("n", "<leader>gg", dapui.toggle, "Toggle DAP UI")
map("n", "<leader>gd", dap.continue, "Start/continue debugging")
map("n", "<leader>gn", dap.step_over, "Step over")
map("n", "<leader>gj", dap.step_into, "Step into")
map("n", "<leader>gk", dap.step_out, "Step out")
map("n", "<leader>gb", dap.toggle_breakpoint, "Toggle breakpoint")
map("n", "<leader>ge", dapui.eval, "Evaluate symbol under cursor")

return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		require("plugins.install.dap.nvim-dap-python"),
		require("plugins.install.dap.nvim-dap-go"),
		require("plugins.install.dap.nvim-dap-ui"),
	},
	config = function()
		require("plugins.install.dap.keybindings")

		local dap = require("dap")
		local dapui = require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
	end,
}

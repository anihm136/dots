return {
	"rcarriga/nvim-notify",
	init = function()
		vim.notify = require("notify")
	end,
	config = function()
		require("notify").setup({
			render = "minimal",
			stages = "slide",
			timeout = 2000,
		})
	end,
}

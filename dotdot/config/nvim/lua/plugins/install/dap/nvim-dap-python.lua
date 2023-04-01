return {
	'mfussenegger/nvim-dap-python',
	config = function()
		require('dap-python').setup('~/dev/python/debugpy/bin/python')
	end
}

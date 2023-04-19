return {
	"nvim-tree/nvim-tree.lua",
	lazy=false,
	config = function()
		require("nvim-tree").setup()

		vim.keymap.set("n", "<leader>0", "<cmd>NvimTreeToggle<cr>")
	end,
}

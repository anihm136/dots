return {
	-- Utilities
	"tpope/vim-eunuch",
	"romainl/vim-cool",

	-- UI

	-- LSP
	--{
	--	"williamboman/mason.nvim",
	--	config = configs.mason,
	--}
	--use {
	--	"williamboman/mason-lspconfig.nvim",
	--	after = "mason.nvim",
	--	config = configs.mason_lspconfig,
	--}
	--use {'neovim/nvim-lspconfig',
	--after = "mason-lspconfig.nvim",
	--config = configs.lspconfig,
	--}

	-- Treesitter
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},
}

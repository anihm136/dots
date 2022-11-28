local configs = require("plugin_config")
local setups = require("plugin_setup")

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- Utilities
		use("tpope/vim-eunuch")
		use({
			"jdhao/better-escape.vim",
			event = "InsertEnter",
			setup = setups.better_escape,
		})
		use("romainl/vim-cool")

		-- UI
 		use {
 			"catppuccin/nvim",
 			as = "catppuccin",
 			config = configs.catpuccin
 		}

		-- LSP
		use {
			"williamboman/mason.nvim",
			config = configs.mason,
		}
		use {
			"williamboman/mason-lspconfig.nvim",
			after = "mason.nvim",
			config = configs.mason_lspconfig,
		}
		use {'neovim/nvim-lspconfig',
		after = "mason-lspconfig.nvim",
		config = configs.lspconfig,
	}

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			config = configs.treesitter,
		}
		use {
				"nvim-treesitter/nvim-treesitter-textobjects",
				after = "nvim-treesitter"
		}
		use {
				"JoosepAlviste/nvim-ts-context-commentstring",
				after = "nvim-treesitter"
		}
		use {
				"nvim-treesitter/playground",
				after = "nvim-treesitter"
		}
	end,
	config = {
		compile_path = vim.fn.stdpath("config") .. "/lua/plugin_install/plugins_compiled.lua",
		ensure_dependencies = true,
	},
})

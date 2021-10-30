local configs = require"plugin_config"
local setups = require"plugin_setup"
local disable_feat = { jinja = true }

return require("packer").startup{
	function(use)
		use"wbthomason/packer.nvim"
		use"lewis6991/impatient.nvim"
		use{
			"dstein64/vim-startuptime",
			cmd = "StartupTime",
		}
		use"tpope/vim-repeat"
		use"tpope/vim-apathy"
		use"airblade/vim-rooter"
		use{
			-- 'anihm136/kommentary',
			"b3nj5m1n/kommentary",
			config = configs.kommentary,
			setup = setups.kommentary,
		}
		use{
			"anihm136/vim-unimpaired",
			setup = setups.unimpaired,
		}
		use"fedorenchik/gtags.vim"
		use"junegunn/vim-easy-align"
		use"Darazaki/indent-o-matic"
		use"tpope/vim-eunuch"
		use{
			"christoomey/vim-tmux-navigator",
			setup = setups.tmux_navigator,
		}
		use{
			"AndrewRadev/splitjoin.vim",
			keys = { "gJ", "gS" },
		}
		use"romainl/vim-qf"
		use{
			"dcampos/nvim-snippy",
			requires = { "honza/vim-snippets" },
		}
		use{
			"tweekmonster/wstrip.vim",
			cmd = "WStrip",
		}
		use{
			"tpope/vim-abolish",
			cmd = { "Abolish", "Subvert" },
			keys = { "crs", "crm", "crc", "cru", "cr-", "cr.", "cr ", "crt" },
		}
		-- LSP/Completion
		use"neovim/nvim-lspconfig"
		use"kabouzeid/nvim-lspinstall"
		use{
			"hrsh7th/nvim-cmp",
			requires = {
				"dcampos/nvim-snippy",
				"onsails/lspkind-nvim",
				"hrsh7th/cmp-nvim-lsp",
				{ "hrsh7th/cmp-buffer" },
				-- after = "hrsh7th/nvim-cmp",
				{ "hrsh7th/cmp-path" },
				-- after = "hrsh7th/nvim-cmp",
				{ "dcampos/cmp-snippy" },
				-- after = "hrsh7th/nvim-cmp",
			},
			event = "InsertEnter",
			config = configs.nvim_cmp,
		}
		use{
			"kosayoda/nvim-lightbulb",
			setup = setups.nvim_lightbulb,
		}
		-- Treesitter
		use{
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-textobjects",
				"JoosepAlviste/nvim-ts-context-commentstring",
				"RRethy/nvim-treesitter-textsubjects",
			},
			config = configs.treesitter,
		}
		-- Git
		use{
			"whiteinge/diffconflicts",
			cmd = {
				"DiffConflicts",
				"DiffConflictsShowHistory",
				"DiffConflictsWithHistory",
			},
		}
		use{
			"lewis6991/gitsigns.nvim",
			config = configs.gitsigns,
		}
		-- Syntax
		use{
			"ekalinin/Dockerfile.vim",
			ft = "Dockerfile",
		}
		use"tpope/vim-git"
		use{
			"McSinyx/vim-octave",
			ft = "octave",
		}
		use"baskerville/vim-sxhkdrc"
		use{
			"wgwoods/vim-systemd-syntax",
			ft = "systemd",
		}
		use{
			"ericpruitt/tmux.vim",
			rtp = "vim/",
			ft = "tmux",
		}
		use{
			"pboettch/vim-cmake-syntax",
			ft = "cmake",
		}
		use{
			"kevinoid/vim-jsonc",
			ft = "jsonc",
		}
		use{
			"chrisbra/csv.vim",
			ft = "csv",
		}
		use"tridactyl/vim-tridactyl"
		-- Language-specific
		use{
			"mattn/emmet-vim",
			ft = {
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"php",
				"jinja.html",
				"htmldjango",
				"vue",
			},
		}
		use{
			"windwp/nvim-ts-autotag",
			ft = {
				"html",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"svelte",
				"php",
			},
		}
		use{
			"Glench/Vim-Jinja2-Syntax",
			disable = disable_feat.jinja,
		}
		-- Textobjects
		use"michaeljsmith/vim-indent-object"
		use"wellle/targets.vim"
		use"chaoren/vim-wordmotion"
		-- UI
		use"anihm136/statusline-themer"
		use"junegunn/rainbow_parentheses.vim"
		use{
			"norcalli/nvim-colorizer.lua",
			ft = { "css", "javascript", "vim", "html" },
			config = function()
				require("colorizer").setup{ "css", "javascript", "vim", "html" }
			end,
		}
		use"TaDaa/vimade"
		use{
			"famiu/feline.nvim",
			config = function()
				vim.o.termguicolors = true
				require("feline").setup()
			end,
		}
		-- use{
		-- 	'hoob3rt/lualine.nvim',
		-- 	config = configs.lualine,
		-- }
		use{
			"goolord/alpha-nvim",
			config = function()
				local alpha = require("alpha")
				local dashboard = require("alpha.themes.dashboard")
				-- Set header
				dashboard.section.header.val =
					{
						"                                                     ",
						"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
						"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
						"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
						"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
						"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
						"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
						"                                                     ",
					}
				-- Set menu
				dashboard.section.buttons.val =
					{
						dashboard.button(
							"e",
							"  > New file",
							":ene <BAR> startinsert <CR>"
						),
						dashboard.button(
							"r",
							"  > Frecent",
							":Telescope frecency<CR>"
						),
						dashboard.button(
							"d",
							"  > Dotfiles",
							':lua require("telescope_config").edit_dotfiles()<CR>'
						),
						dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
					}
				-- Set footer
				local fortune = require("alpha.fortune")
				dashboard.section.footer.val = fortune()
				-- Send config to alpha
				alpha.setup(dashboard.opts)
				-- Disable folding on alpha buffer
				vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
			end,
		}
		-- UX
		-- use'cohama/lexima.vim'
		use{
			"anihm136/auto-pairs",
			config = function()
				vim.g.AutoPairsMapBS = true
				vim.g.AutoPairsCompleteOnlyOnSpace = true
				vim.g.AutoPairsShortcutToggleMultilineClose = ""
				vim.g.AutoPairsMultilineClose = true
				vim.g.AutoPairsCompatibleMaps = false
			end,
		}
		use{
			"psliwka/vim-smoothie",
			keys = { "<C-d>", "<C-u>", "<C-f>", "<C-b>" },
		}
		use{
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = configs.nvim_tree,
		}
		use{
			"justinmk/vim-dirvish",
			requires = { "kyazdani42/nvim-web-devicons" },
			cmd = { "Dirvish" },
		}
		use{
			"machakann/vim-sandwich",
			config = configs.sandwich,
		}
		use{
			"ggandor/lightspeed.nvim",
			keys = {
				"<Plug>Lightspeed_s",
				"<Plug>Lightspeed_S",
				"<Plug>Lightspeed_x",
				"<Plug>Lightspeed_X",
				"<Plug>Lightspeed_f",
				"<Plug>Lightspeed_F",
				"<Plug>Lightspeed_t",
				"<Plug>Lightspeed_T",
			},
			setup = function()
				local default_keymaps =
					{
						{ "n", "s", "<Plug>Lightspeed_s" },
						{ "n", "S", "<Plug>Lightspeed_S" },
						{ "x", "s", "<Plug>Lightspeed_s" },
						{ "o", "z", "<Plug>Lightspeed_s" },
						{ "o", "Z", "<Plug>Lightspeed_S" },
						{ "o", "x", "<Plug>Lightspeed_x" },
						{ "o", "X", "<Plug>Lightspeed_X" },
						{ "n", "f", "<Plug>Lightspeed_f" },
						{ "n", "F", "<Plug>Lightspeed_F" },
						{ "x", "f", "<Plug>Lightspeed_f" },
						{ "x", "F", "<Plug>Lightspeed_F" },
						{ "o", "f", "<Plug>Lightspeed_f" },
						{ "o", "F", "<Plug>Lightspeed_F" },
						{ "n", "t", "<Plug>Lightspeed_t" },
						{ "n", "T", "<Plug>Lightspeed_T" },
						{ "x", "t", "<Plug>Lightspeed_t" },
						{ "x", "T", "<Plug>Lightspeed_T" },
						{ "o", "t", "<Plug>Lightspeed_t" },
						{ "o", "T", "<Plug>Lightspeed_T" },
					}
				for _, m in ipairs(default_keymaps) do
					vim.api.nvim_set_keymap(m[1], m[2], m[3], { silent = true })
				end
			end,
		}
		use{
			"phaazon/hop.nvim",
			config = configs.hop,
		}
		use{ "haya14busa/vim-asterisk" }
		use"romainl/vim-cool"
		use{
			"andymass/vim-matchup",
			config = configs.matchup,
		}
		use{
			"jdhao/better-escape.vim",
			event = "InsertEnter",
			setup = setups.better_escape,
		}
		use{
			"inside/vim-search-pulse",
			keys = { "<Plug>(pulse)" },
		}
		use{
			"brooth/far.vim",
			cmd = { "Far", "Farp", "Farr", "Farf" },
		}
		-- Themes
		use"AlessandroYorba/Despacio"
		use"chuling/equinusocio-material.vim"
		use"habamax/vim-gruvbit"
		use"git@gitlab.com:protesilaos/tempus-themes-vim"
		use"franbach/miramare"
		use"lifepillar/vim-solarized8"
		use"wadackel/vim-dogrun"
		use"folke/tokyonight.nvim"
		use"EdenEast/nightfox.nvim"
		-- Experimental
		use{
			"anihm136/importmagic.nvim",
			ft = "python",
			run = ":UpdateRemotePlugins",
		}
		use"mfussenegger/nvim-dap"
		use{
			"jpalardy/vim-slime",
			ft = "python",
		}
		-- use{
		-- 	"michaelb/sniprun",
		-- 	run = "bash ./install.sh",
		-- 	cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipClose" },
		-- 	config = function()
		-- 		require"sniprun".setup{ display = { "Terminal" } }
		-- 	end,
		-- }
		use{
			"thinca/vim-quickrun",
			config = function()
				vim.cmd[[ runtime after/plugin/quickrun.vim ]]
			end,
			requires = { {
				"Shougo/vimproc.vim",
				run = "make",
			} },
		}
		-- Nvim
		use"antoinemadec/FixCursorHold.nvim"
		use{
			"Shatur/neovim-session-manager",
			config = function()
				require("session_manager").setup{
					autoload_last_session = false,
				}
			end,
		}
		use{
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
			},
		}
		use{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			requires = { "nvim-telescope/telescope.nvim" },
		}
		use{
			"nvim-telescope/telescope-frecency.nvim",
			requires = { "nvim-telescope/telescope.nvim", "tami5/sql.nvim" },
		}
		use{
			"nvim-telescope/telescope-symbols.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
		}
		use"weilbith/nvim-lsp-smag"
		use"nathom/filetype.nvim"
	end,
	config = {
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		ensure_dependencies = true,
	},

}

local configs = require'plugin_config'
local setups = require'plugin_setup'

return require('packer').startup{
	function(use)
		use'wbthomason/packer.nvim'

		use'lewis6991/impatient.nvim'

		use{
			'dstein64/vim-startuptime',
			cmd = 'StartupTime',
		}

		use'tpope/vim-repeat'
		
		use'tpope/vim-apathy'

		use'airblade/vim-rooter'

		-- use 'b3nj5m1n/kommentary'

		use{
			'anihm136/kommentary',
			config = configs.kommentary,
			setup = setups.kommentary,
		}

		use{
			'anihm136/vim-unimpaired',
			setup = setups.unimpaired,
		}

		use'fedorenchik/gtags.vim'

		use'junegunn/vim-easy-align'

		use'Darazaki/indent-o-matic'

		use'tpope/vim-eunuch'

		use{
			'christoomey/vim-tmux-navigator',
			setup = setups.tmux_navigator,
		}

		use{
			'AndrewRadev/splitjoin.vim',
			keys = { 'gJ', 'gS' },
		}

		use'romainl/vim-qf'

		use{
			'dcampos/nvim-snippy',
			requires = { 'honza/vim-snippets' },
		}

		-- LSP/Completion

		use'neovim/nvim-lspconfig'

		use'kabouzeid/nvim-lspinstall'

		use{
			'hrsh7th/nvim-cmp',
			requires = { 'dcampos/nvim-snippy', {
				'hrsh7th/cmp-buffer',
				after = 'nvim-cmp',
			}, 'hrsh7th/cmp-nvim-lsp', {
				'hrsh7th/cmp-path',
				after = 'nvim-cmp',
			}, {
				'dcampos/cmp-snippy',
				after = 'nvim-cmp',
			}, 'onsails/lspkind-nvim' },
			event = 'InsertEnter',
			config = configs.nvim_cmp,
		}

		use{
			'kosayoda/nvim-lightbulb',
			setup = setups.nvim_lightbulb,
		}

		-- Treesitter
		use{
			'nvim-treesitter/nvim-treesitter',
			requires = {
				'nvim-treesitter/nvim-treesitter-textobjects',
				'JoosepAlviste/nvim-ts-context-commentstring',
			},
			config = configs.treesitter,
		}

		-- Git

		use'whiteinge/diffconflicts'

		use{
			'lewis6991/gitsigns.nvim',
			config = configs.gitsigns,
		}

		-- Syntax

		use{
			'ekalinin/Dockerfile.vim',
			ft = 'Dockerfile',
		}

		use'tpope/vim-git'

		use{
			'McSinyx/vim-octave',
			ft = 'octave',
		}

		use'baskerville/vim-sxhkdrc'

		use{
			'wgwoods/vim-systemd-syntax',
			ft = 'systemd',
		}

		use{
			'ericpruitt/tmux.vim',
			rtp = 'vim/',
			ft = 'tmux',
		}

		use{
			'pboettch/vim-cmake-syntax',
			ft = 'cmake',
		}

		use{
			'kevinoid/vim-jsonc',
			ft = 'jsonc',
		}

		use{
			'chrisbra/csv.vim',
			ft = 'csv',
		}

		use'tridactyl/vim-tridactyl'

		-- Language-specific

		use{
			'mattn/emmet-vim',
			ft = {
				'html',
				'javascript',
				'typescript',
				'javascriptreact',
				'typescriptreact',
				'php',
				'htmljinja',
				'htmldjango',
				'vue',
			},
		}

		use{
			'mitsuhiko/vim-jinja',
			ft = { 'html', 'htmldjango' },
		}

		-- Textobjects

		use'michaeljsmith/vim-indent-object'

		use'wellle/targets.vim'

		use'chaoren/vim-wordmotion'

		-- UI

		use'anihm136/statusline-themer'

		use'junegunn/rainbow_parentheses.vim'

		use{
			'norcalli/nvim-colorizer.lua',
			ft = { 'css', 'javascript', 'vim', 'html' },
			config = function()
				require('colorizer').setup{ 'css', 'javascript', 'vim', 'html' }
			end,
		}

		use'TaDaa/vimade'

		use{
			'hoob3rt/lualine.nvim',
			config = configs.lualine,
		}

		-- UX

		use'cohama/lexima.vim'

		use'psliwka/vim-smoothie'

		use{
			'kyazdani42/nvim-tree.lua',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = configs.nvim_tree,
		}

		use{
			'justinmk/vim-dirvish',
			requires = { 'kyazdani42/nvim-web-devicons' },
		}

		use'ggandor/lightspeed.nvim'

		use{
			'phaazon/hop.nvim',
			config = configs.hop,
		}

		use'haya14busa/vim-asterisk'

		use{
			'machakann/vim-sandwich',
			setup = setups.sandwich,
		}

		use'romainl/vim-cool'

		use{
			'andymass/vim-matchup',
			config = configs.matchup,
		}

		use{
			'jdhao/better-escape.vim',
			event = 'InsertEnter',
			setup = setups.better_escape,
		}

		use'inside/vim-search-pulse'

		-- Themes

		use'AlessandroYorba/Despacio'

		use'chuling/equinusocio-material.vim'

		use'habamax/vim-gruvbit'

		use'https://gitlab.com/protesilaos/tempus-themes-vim'

		use'franbach/miramare'

		use'lifepillar/vim-solarized8'

		use'wadackel/vim-dogrun'

		use'folke/tokyonight.nvim'

		use'EdenEast/nightfox.nvim'

		-- Experimental

		use{
			'anihm136/importmagic.nvim',
			ft = 'python',
			run = ':UpdateRemotePlugins',
		}

		use'mfussenegger/nvim-dap'

		use{
			'jpalardy/vim-slime',
			ft = 'python',
		}

		-- Nvim

		use'antoinemadec/FixCursorHold.nvim'

		use{
			'nvim-telescope/telescope.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				'kyazdani42/nvim-web-devicons',
			},
		}

		use{
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
			requires = { 'nvim-telescope/telescope.nvim' },
		}

		use{
			'nvim-telescope/telescope-frecency.nvim',
			requires = { 'nvim-telescope/telescope.nvim', 'tami5/sql.nvim' },
		}

		use{
			'nvim-telescope/telescope-symbols.nvim',
			requires = { 'nvim-telescope/telescope.nvim' },
		}

		use'rmagatti/auto-session'

		use'rmagatti/session-lens'

		use'weilbith/nvim-lsp-smag'

		use'nathom/filetype.nvim'
	end,
	config = {
		compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
		ensure_dependencies = true,
	},

}

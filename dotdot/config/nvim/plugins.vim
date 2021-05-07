call plug#begin('~/.local/share/nvim/plugged')
Plug 'dstein64/vim-startuptime'
Plug 'tpope/vim-repeat'
Plug 'kreskij/Repeatable.vim', { 'on': 'Repeatable' }
Plug 'airblade/vim-rooter'
Plug 'b3nj5m1n/kommentary'
Plug 'anihm136/vim-unimpaired'
Plug 'fedorenchik/gtags.vim'
Plug 'norcalli/snippets.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'roryokane/detectindent'
Plug 'tpope/vim-eunuch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'justinmk/vim-dirvish'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'romgrk/searchReplace.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'romainl/vim-qf'
" Git
Plug 'rhysd/git-messenger.vim'
Plug 'whiteinge/diffconflicts'
" Syntax
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
Plug 'tpope/vim-git'
Plug 'McSinyx/vim-octave', {'for': 'octave'}
Plug 'baskerville/vim-sxhkdrc'
Plug 'wgwoods/vim-systemd-syntax', {'for': 'systemd'}
Plug 'ericpruitt/tmux.vim', {'rtp': 'vim/', 'for': 'tmux'}
Plug 'pboettch/vim-cmake-syntax', {'for': 'cmake'}
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}
" Language-specific
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'php', 'htmljinja', 'htmldjango', 'vue']}
Plug 'mitsuhiko/vim-jinja', {'for': ['html','htmldjango']}
" Textobjects
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
" UI
Plug 'anihm136/statusline-themer'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-startify'
Plug 'TaDaa/vimade'
Plug 'hoob3rt/lualine.nvim'
" UX
Plug 'cohama/lexima.vim'
Plug 'psliwka/vim-smoothie'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-asterisk'
Plug 'machakann/vim-sandwich'
Plug 'romainl/vim-cool'
Plug 'andymass/vim-matchup'
Plug 'jdhao/better-escape.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'inside/vim-search-pulse'
" Themes
Plug 'AlessandroYorba/Despacio'
Plug 'chuling/equinusocio-material.vim'
Plug 'habamax/vim-gruvbit'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'franbach/miramare'
Plug 'lifepillar/vim-solarized8'
Plug 'wadackel/vim-dogrun'
" Experimental
Plug 'metakirby5/codi.vim', {'on': 'Codi'}
Plug 'anihm136/importmagic.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'mfussenegger/nvim-dap'
Plug 'thinca/vim-quickrun'
Plug 'jpalardy/vim-slime'
" Nvim
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'anihm136/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-cheat.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()
 
runtime macros/sandwich/keymap/surround.vim

" Unimpaired
let g:unimpaired_mapping = {
			\	"toggles" : 0,
			\	"excludes" : {
			\		'nextprevs' : ['f', 'a', 'q', 'l'],
			\		'keys' : ['=P', '[P', ']P']
			\	}
			\ }

" LSP Diagnostics
call sign_define("LspDiagnosticsSignError", {"text" : "◉", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "💡", "texthl" : "LspDiagnosticHint"})

" Quickrun
let g:quickrun_no_default_key_mappings = 1

" Better-escape
let g:better_escape_interval = 300
let g:better_escape_shortcut = 'fd'

" Matchup
let g:matchup_matchparen_offscreen = {}

" Kommentary
let g:kommentary_create_default_mappings = 0

" Pulse
let g:vim_search_pulse_mode = 'pattern'
let g:vim_search_pulse_disable_auto_mappings = 1

map *  <Plug>(asterisk-z*)<Plug>(pulse)
map #  <Plug>(asterisk-z#)<Plug>(pulse)
map g* <Plug>(asterisk-gz*)<Plug>(pulse)
map g# <Plug>(asterisk-gz#)<Plug>(pulse)
nmap n n<Plug>Pulse
nmap N N<Plug>Pulse

" Tmux-navigator
let g:tmux_navigator_no_mappings = 1


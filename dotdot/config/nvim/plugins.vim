call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-rooter'
Plug 'tomtom/tcomment_vim'
Plug 'anihm136/vim-unimpaired'
Plug 'fedorenchik/gtags.vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'sbdchd/neoformat'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'roryokane/detectindent'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'justinmk/vim-dirvish'
Plug 'antonk52/dirvish-fs.vim'
Plug 'kkoomen/vim-doge'
Plug 'romgrk/searchReplace.vim'
" Git
Plug 'rhysd/git-messenger.vim'
Plug 'whiteinge/diffconflicts'
" Syntax
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-git'
Plug 'McSinyx/vim-octave', {'for': 'octave'}
Plug 'baskerville/vim-sxhkdrc'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'ericpruitt/tmux.vim', {'rtp': 'vim/'}
Plug 'pboettch/vim-cmake-syntax'
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
Plug 'chrisbra/csv.vim'
" Language-specific
Plug 'captbaritone/better-indent-support-for-php-with-html', {'for': 'php'}
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'php', 'htmljinja', 'htmldjango']}
Plug 'mitsuhiko/vim-jinja', {'for': ['html','htmldjango']}
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'
" Textobjects
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
" UI
Plug 'anihm136/statusline-themer'
Plug 'ap/vim-buftabline'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-startify'
Plug 'TaDaa/vimade'
" UX
Plug 'cohama/lexima.vim'
Plug 'psliwka/vim-smoothie'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-asterisk'
Plug 'machakann/vim-sandwich'
Plug 'romainl/vim-cool'
Plug 'andymass/vim-matchup'
" Themes
Plug 'AlessandroYorba/Despacio'
Plug 'ajh17/Spacegray.vim'
Plug 'chuling/equinusocio-material.vim'
Plug 'habamax/vim-gruvbit'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'https://gitlab.com/yorickpeterse/happy_hacking.vim.git'
Plug 'jacoborus/tender.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'wadackel/vim-dogrun'
" Experimental
Plug 'metakirby5/codi.vim', {'on': 'Codi'}
Plug 'anihm136/importmagic.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'mfussenegger/nvim-dap'
Plug 'thinca/vim-quickrun'
Plug 'jpalardy/vim-slime'
" Nvim
Plug 'anihm136/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tjdevries/express_line.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-cheat.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()
 
runtime macros/sandwich/keymap/surround.vim

" Buftabline
hi! link BufTabLineFill Normal
hi! link BufTabLineActive Pmenu
hi! link BufTabLineCurrent PmenuSel
hi! link BufTabLineHidden Pmenu
let g:buftabline_indicators = 1

" Unimpaired
let g:unimpaired_mapping = {
			\	"toggles" : 0,
			\	"excludes" : {
			\		'nextprevs' : ['f', 'a', 'q', 'l'],
			\		'keys' : ['>p', '<p', '>P', '<P', '=P', '[P', ']P']
			\	}
			\ }

" Ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="google"
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsJumpForwardTrigger="<nop>"
let g:UltiSnipsJumpBackwardTrigger="<nop>"

let g:ulti_expand_or_jump_res = 0
function! UltiSnipFunc()
	call UltiSnips#ExpandSnippetOrJump()
	return g:ulti_expand_or_jump_res
endfunction
smap <silent> <TAB>   <Esc><cmd>call UltiSnips#JumpForwards()<CR>
smap <silent> <S-TAB> <Esc><cmd>call UltiSnips#JumpBackwards()<CR>

" Diagnostic nvim
call sign_define("LspDiagnosticsSignError", {"text" : "◉", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "💡", "texthl" : "LspDiagnosticHint"})

" Quickrun
let g:quickrun_no_default_key_mappings = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Credits to Amir Salihefendic — @amix3k
"
"              _ _               __   _____  ____ _             _
"             (_) |             /  | |____ |/ ___( )           (_)
"   __ _ _ __  _| |__  _ __ ___ `| |     / / /___|/ ___  __   ___ _ __ ___  _ __ ___
"  / _` | '_ \| | '_ \| '_ ` _ \ | |     \ \ ___ \ / __| \ \ / / | '_ ` _ \| '__/ __|
" | (_| | | | | | | | | | | | | || |_.___/ / \_/ | \__ \  \ V /| | | | | | | | | (__
"  \__,_|_| |_|_|_| |_|_| |_| |_\___/\____/\_____/ |___/   \_/ |_|_| |_| |_|_|  \___|
"
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Goyo
nmap <silent> <leader>gy :Goyo<cr>

" Dirvish

" DB
nnoremap <buffer> <leader>sd :DB b:db =<Space>
vnoremap <buffer><silent> <leader>se :DB<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
{%@@ if profile == "sorcery" @@%}
let g:python3_host_prog = "/home/anihm136/dev/python/tool-env/bin/python"
{%@@ elif profile == "apex" @@%}
let g:python3_host_prog = "/home/anirudh/dev/python/tool-env/bin/python"
{%@@ endif @@%}

set splitbelow splitright
set confirm
set smarttab
set shiftround
set termguicolors
set mouse=a
set cscopeprg=cscope
set history=500
filetype plugin indent on
set autoread
set noshowcmd
set noshowmode
set undofile
set nrformats-=octal
set clipboard=unnamedplus
set signcolumn=yes
set updatetime=200
set inccommand=nosplit
set scrolloff=3
set shortmess=actI
set fillchars+=vert:│
set listchars=eol:↲,tab:»\ ,trail:𝁢,extends:…,precedes:…,conceal:┊
set list
set cursorline
set completeopt=menu,menuone,noselect


nnoremap <silent> <leader>fs :wa!<cr>
xnoremap <silent> y ygv<Esc>
inoremap <silent> <C-v> <C-o>P
nnoremap <silent> <leader>tw :set wrap!<cr>
nnoremap gx :<C-u>!$BROWSER <C-r><C-f><cr>
inoremap <silent><expr> <Tab>   v:lua.helpers.tab_complete()
inoremap <silent><expr> <S-Tab> v:lua.helpers.s_tab_complete()
xnoremap <silent> <Tab> v:lua.helpers.x_tab()

function! s:show_documentation()
	if (index(['vim','help', 'lua'], &filetype) >= 0)
		try
			execute 'h '.expand('<cword>')
			return
		catch
		endtry
	endif
	try
		execute 'lua vim.lsp.buf.hover()'
	catch
		echoerr "No help available for " . expand('<cword>')
	endtry
endfunction

nnoremap <silent> K <cmd>call <SID>show_documentation()<CR>

augroup custom_commands
	autocmd!
augroup END

autocmd custom_commands FileType * set formatoptions=lcqnrj
autocmd custom_commands VimResized * wincmd =
autocmd custom_commands FocusGained,BufEnter * checktime
autocmd custom_commands FileType help,plugins,fugitive nnoremap <silent><buffer> q :q<cr>
autocmd custom_commands FileType qf call helpers#mapQf()
autocmd custom_commands BufWritePost init.vim,plugins.vim,genconfig.vim nested silent source %
autocmd custom_commands BufReadPost,BufNewFile * DetectIndent
autocmd custom_commands TextYankPost *  silent! lua require'vim.highlight'.on_yank()
autocmd custom_commands FileType html,jinja,htmldjango,php nnoremap <silent><buffer> <F7> :call helpers#toggleFt()<cr>

command! -nargs=0 Reload call helpers#vim_reload()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $LANG='en'
set langmenu=en

set wildmenu
set wildmode=full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,node_modules
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set relativenumber number
set cmdheight=2
set pumheight=10
set pumwidth=50
set pumblend=20
set hidden
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set nostartofline
set noerrorbells
set novisualbell
set tm=500
set diffopt&
			\ diffopt+=vertical
			\ diffopt+=hiddenoff

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable

command! -nargs=? -complete=customlist,CompleteColors SetColorscheme call helpers#setColorscheme(<f-args>)
nnoremap <silent><F12> :SetColorscheme dark<cr>
nnoremap <silent><F24> :SetColorscheme light<cr>
silent exec "SetColorscheme"

set encoding=utf8
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set lbr
set tw=500

set autoindent
set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader><leader> :noh<cr>

map j gj
map k gk
map <Down> gj
map <Up> gk
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
nnoremap . :<C-u>execute "norm! " . repeat(".", v:count1)<CR>

nnoremap <silent><leader>bd :call helpers#bufcloseCloseIt()<cr>
nnoremap <silent><leader>wd :call helpers#bufcloseCloseIt() \| q<cr>

nnoremap <leader>e :edit <c-r>=fnameescape(expand("%:p:h"))<cr>/
nnoremap <leader>pd :cd %:p:h <bar> pwd<cr>

set switchbuf=useopen,usetab

autocmd custom_commands BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap Y y$
nnoremap x "_x
xnoremap <expr> p printf('pgv"%sygv<esc>', v:register)
vnoremap o $

nnoremap B :<C-u>call helpers#breakLine()<CR>

if &wildoptions =~ "pum"
	cnoremap <expr> <up>   pumvisible() ? "<C-p>" : "\<up>"
	cnoremap <expr> <down> pumvisible() ? "<C-n>" : "\<down>"
	cnoremap <expr> <left> pumvisible() ? "<up>" : "<left>"
	cnoremap <expr> <right> pumvisible() ? "<down>" : "<right>"
endif

autocmd custom_commands BufRead,BufNewFile,VimEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.c,*.cpp,*.go let g:nav_mode = 1
autocmd custom_commands BufRead,BufNewFile,VimEnter *.java,*.lua let g:nav_mode = -1
autocmd custom_commands BufRead,BufNewFile,VimEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.c,*.cpp,*.java,*.go,*.lua silent call ProgFunc()

nnoremap <silent> <Leader>rn :%s///g<Left><Left>
nnoremap <silent> <Leader>rc :%s///gc<Left><Left><Left>
xnoremap <silent> <Leader>rn :s///g<Left><Left>
xnoremap <silent> <Leader>rc :s///gc<Left><Left><Left>

nnoremap <F2>
			\ :let @s='\<'.expand('<cword>').'\>'<CR>
			\ :Grepper -cword -noprompt<CR>
			\ :cfdo %s/<C-r>s//g \| update
			\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

xnoremap <F2>
			\ "sy
			\ :Grepper -noprompt -query <C-r>s<CR>
			\ :let @s='\<'.@s.'\>'<CR>
			\ :cfdo %s/<C-r>s//g \| update
			\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text objects
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap <silent> in :<C-u>call VisualNumber()<CR>
onoremap <silent> in :<C-u>normal vin<CR>

xnoremap <silent> ig :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
onoremap <silent> ig :<C-u>normal vig<CR>
xnoremap <silent> ag GoggV
onoremap <silent> ag :<C-u>normal vag<CR>

xnoremap <silent> il g_o^
onoremap <silent> il :<C-u>normal vil<CR>
xnoremap <silent> al $o0
onoremap <silent> al :<C-u>normal val<CR>

for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CompleteColors(ArgLead, CommandLine, CursorColumn) abort
	let l:comp = extend(getcompletion('', 'color'), ['dark', 'light'])
	let l:pat = '^'.a:ArgLead
	call filter(l:comp, {idx,val -> val =~ l:pat})
	return l:comp
endfunction

function! ProgFunc() abort
	silent exec "RainbowParentheses"
	if !get(g:, "nav_mode")
		let g:nav_mode = helpers#toggleTags()
	else
		call helpers#navMap(g:nav_mode)
	endif
endfunction

source ~/.config/nvim/disablePlugins.vim
let g:do_filetype_lua = 1
" runtime! ftdetect/*.vim
" runtime! ftdetect/*.lua
luafile ~/.config/nvim/plugins.lua
source ~/.config/nvim/colorscheme_options.vim
luafile ~/.config/nvim/start.lua
source ~/.config/nvim/genconfig.vim

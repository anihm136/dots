if !get(g:, "loaded_tmux_navigator", v:false)
	finish
endif

nnoremap <silent> <C-h> <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <C-k> <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <C-;> <cmd>TmuxNavigateRight<cr>
nnoremap <silent> <C-\> <cmd>TmuxNavigatePrevious<cr>

if !get(g:, 'loaded_gitgutter', v:false)
	finish
endif

let g:gitgutter_map_keys=0
map <silent> <Leader>gF :GitGutterFold<cr>


if !get(g:, 'loaded_gtags', v:false)
	finish
endif

let g:Gtags_No_Auto_Jump = 1
nnoremap <silent> <F6> <cmd>call helpers#toggleTags()<cr>


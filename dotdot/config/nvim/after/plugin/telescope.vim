if !get(g:, "loaded_telescope", v:false)
	finish
endif

nnoremap <silent> <leader>ff <cmd>lua require('telescope_config').project_search()<CR>
nnoremap <silent> <leader>fg <cmd>lua require('telescope_config').git_files()<CR>
nnoremap <silent> <leader>fd <cmd>lua require('telescope_config').edit_dotfiles()<CR>
nnoremap <silent> <leader>fr <cmd>lua require('telescope_config').recent()<CR>
nnoremap <silent> <leader>rl <cmd>lua require('telescope_config').live_grep()<CR>
nnoremap <silent> <leader>rw <cmd>lua require('telescope_config').grep_prompt()<CR>
nnoremap <silent> <leader>, <cmd>lua require('telescope_config').buffers()<CR>
nnoremap <silent> <leader>sb <cmd>lua require('telescope_config').curbuf()<CR>
nnoremap <silent> <leader>fh <cmd>lua require('telescope_config').help_tags()<CR>
nnoremap <silent> <leader>ss <cmd>lua require('session-lens').search_session()<CR>
nnoremap <silent> g0 <cmd>lua require('telescope_config').lsp_document_symbols()<CR><CR>
nnoremap <silent> gW <cmd>lua require('telescope_config').lsp_workspace_symbols()<CR><CR>

if !get(g:, "loaded_telescope", v:false)
	finish
endif

nnoremap <silent> <leader>ff <cmd>lua require('telescope_config').project_search()<cr>
nnoremap <silent> <leader>fg <cmd>lua require('telescope_config').git_files()<cr>
nnoremap <silent> <leader>fp <cmd>lua require('telescope_config').edit_dotfiles()<cr>
nnoremap <silent> <leader>fr <cmd>lua require('telescope_config').recent()<cr>
nnoremap <silent> <leader>/ <cmd>lua require('telescope_config').live_grep()<cr>
nnoremap <silent> <leader>rw <cmd>lua require('telescope_config').grep_prompt()<cr>
nnoremap <silent> <leader>, <cmd>lua require('telescope_config').buffers()<cr>
nnoremap <silent> <leader>sb <cmd>lua require('telescope_config').curbuf()<cr>
nnoremap <silent> <leader>fh <cmd>lua require('telescope_config').help_tags()<cr>
nnoremap <silent> <leader>ss <cmd>lua require('session-lens').search_session()<cr>
nnoremap <silent> g0 <cmd>lua require('telescope_config').lsp_document_symbols()<cr><cr>
nnoremap <silent> gW <cmd>lua require('telescope_config').lsp_workspace_symbols()<cr><cr>

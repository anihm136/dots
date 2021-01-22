if !get(g:, 'loaded_completion', v:false)
	finish
endif

autocmd BufEnter * lua require'completion'.on_attach()
imap <expr><silent> <Tab> pumvisible() 
			\ ? "\<C-n>" 
			\ : "\<C-r>=(UltiSnipFunc()>0)?\"\":\"\<Tab>\"<CR>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 0
inoremap <silent><expr> <c-space> completion#trigger_completion()
let g:completion_auto_change_source = 1
let g:completion_confirm_key = ""
imap <expr> <CR>  pumvisible() 
			\ ? complete_info()["selected"] != "-1" 
			\ ? "\<Plug>(completion_confirm_completion)"  
			\ : "\<c-e>\<CR>" 
			\ : "\<CR>"


let g:completion_chain_complete_list = {
			\ 'vim': [
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\],
			\ 'octave': [
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\],
			\ 'lua': [
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\],
			\ 'sql': [
			\    {'complete_items': ['vim-dadbod-completion']},
			\    {'mode': '<c-n>'}
			\],
			\ 'default': [
			\    {'complete_items': ['lsp', 'path']},
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\]
			\}

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

if !get(g:, 'loaded_ale', v:false)
	finish
endif

nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> <leader>ce <cmd>lopen<cr>
let g:ale_linters_explicit = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_typescript_eslint_executable = 'eslint_d'

let g:ale_linters = {
			\ "sh" : ["shell", "language_server"],
			\ "zsh" : ["shell", "language_server"],
			\ "vim" : ["ale_custom_linting_rules"],
			\ "text" : ["proselint"]
			\}
let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'javascript': ['eslint'],
			\}
nnoremap <silent><F4> :ALEFix<cr>

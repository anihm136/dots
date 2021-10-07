if !get(g:, "loaded_quickrun", v:false)
	finish
endif

" Define a custom outputter for browser
let s:outputter = quickrun#outputter#browser#new()
function! s:outputter.validate() abort
endfunction

let s:outputter.name = "firefox"
let s:outputter.kind = "outputter"

function! s:outputter.finish(session) abort
	try
		call system('firefox ' . self._file)
	endtry
endfunction

call quickrun#module#register(s:outputter)

" Quickrun config
let g:quickrun_config = {}

let g:quickrun_config['_'] = {
			\'runner': 'vimproc',
			\}

let g:quickrun_config.c = {
			\'type':'c/clang',
			\}

let g:quickrun_config.cpp = {
			\'type':'cpp/clang++',
			\}

let g:quickrun_config.javascript = {
			\'type':'javascript/nodejs',
			\}

let g:quickrun_config.lua = {
			\'command':'lua',
			\}

let g:quickrun_config.markdown = {
			\'command': 'pandoc',
			\'exec': '%c --from=gfm --to=html %o %s %a',
			\'outputter': 'firefox'
			\}

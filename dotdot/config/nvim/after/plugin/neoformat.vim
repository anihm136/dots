let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style=file'],
            \ 'stdin': 1
            \ }

let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style=file'],
            \ 'stdin': 1
            \ }

let g:neoformat_lua_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--parser=lua'],
            \ 'stdin': 0
            \ }

let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['black', 'isort']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_javascriptreact = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_sql = ['sqlformat']
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_lua = ['prettier']
nnoremap <silent> <leader>cf :undojoin <bar> Neoformat<CR>

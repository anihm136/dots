function! helpers#bufcloseCloseIt() abort
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
  silent redrawtabline
endfunction

function! helpers#setColorscheme(...) abort
  if a:0 == 0
    let l:color = 'dark'
  else
    let l:color = a:1
  endif
  if l:color == 'dark' || l:color == 'light'
    silent exec "set background=" . l:color
    let l:colorscheme = v:lua.helpers.get_random_colorscheme(l:color)
    exec "colorscheme " . l:colorscheme
    echo l:colorscheme
  else
    exec "colorscheme " . l:color
    echo l:color
  endif
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight FoldColumn ctermbg=NONE guibg=NONE
  highlight Comment gui=italic
  highlight! link TabLineFill Normal
  highlight! link TabLineSel PmenuSel
  lua helpers.set_sl_colors()
endfunction

function! helpers#vim_reload() abort
    silent! update
    call system('kill -USR1 $(ps -p $(ps -p $$ -o ppid=) -o ppid=)')
    qa!
endfunction

function! helpers#breakLine() abort
  s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
  call histdel("/", -1)
endfunction

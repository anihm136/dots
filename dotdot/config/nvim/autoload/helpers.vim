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

  let l:dark_themes = ["gruvbit", "equinusocio_material", "solarized8_flat", "despacio", "dogrun", "miramare", "tokyonight", "nightfox"]

  let l:light_themes = ["solarized8_flat", "tempus_totus", "tempus_day", "tokyonight"]

  let l:all_themes = extend(copy(dark_themes), light_themes)

  let l:select = [dark_themes, light_themes]

  if l:color == 'dark' || l:color == 'light'
    let g:solarized_italics = 0
    let g:solarized_extra_hi_groups = 1
    let g:equinusocio_material_style = 'darker'
    let g:equinusocio_material_hide_vertsplit = 1
    let g:despacio_Twilight = 1
    let g:tokyonight_style = (l:color == 'dark' ? 'storm' : 'day')
    let g:tokyonight_italic_keywords = 0
    silent exec "set background=" . l:color
    let l:theme_set = select[(l:color == 'dark' ? 0 : 1)]
    let l:themeIndex = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % len(l:theme_set)
    let l:colorscheme = l:theme_set[l:themeIndex]
    exec "colorscheme " . l:colorscheme
    echo l:colorscheme
  else
    exec "colorscheme " . l:color
    echo l:color
  endif
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight FoldColumn ctermbg=NONE guibg=NONE
  " lua helpers.makeColorChanges()
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

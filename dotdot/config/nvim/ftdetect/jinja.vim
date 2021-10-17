" fun! s:TryDetectJinja()
"   if exists("b:did_jinja_autodetect")
"     return
"   endif
"   let b:did_jinja_autodetect=1

"   let n = 1
"   while n < 50 && n < line("$")
"     let line = getline(n)
"     if line =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>' || line =~ '{{\s*\S+[|(]'
"       setlocal filetype=jinja.html
"       return
"     endif
"     let n = n + 1
"   endwhile
" endfun

" fun! s:ConsiderSwitchingToJinja()
"   if exists("b:did_jinja_autodetect")
"     return
"   endif
"   let b:did_jinja_autodetect=1

"   let n = 1
"   while n < 100 && n < line("$")
"     let line = getline(n)
"     " Bail on django specific tags
"     if line =~ '{%\s*\(load\|autoescape \(on\|off\)\|cycle\|empty\)\>'
"       return
"     " Bail on django filter syntax
"     elseif line =~ '\({%\|{{\).*|[a-zA-Z0-9]\+:'
"       return
"     endif
"     let n = n + 1
"   endwhile
"   setlocal filetype=jinja.html
" endfun

" fun! s:ConsiderSwitchingToJinjaAgain()
"   unlet b:did_jinja_autodetect
"   call s:TryDetectJinja()
" endfun

" autocmd FileType htmldjango call s:ConsiderSwitchingToJinja()
" autocmd FileType html call s:TryDetectJinja()

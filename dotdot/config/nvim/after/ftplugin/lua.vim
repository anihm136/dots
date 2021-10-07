let &l:include = '\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+'
let s:sid = expand('<SID>')
let &l:includeexpr = s:sid . 'LuaInclude(v:fname)'

function! s:LuaInclude(fname) abort
	let module = substitute(a:fname, '\.', '/', 'g')
	let paths = nvim_list_runtime_paths()
	for template in paths
		let template .= '/lua/'
		let chk1 = template . module . '.lua'
		let chk2 = template . module . '/init.lua'
		if filereadable(chk1)
			return chk1
		elseif filereadable(chk2)
			return chk2
		endif
	endfor
	return a:fname
endfunction

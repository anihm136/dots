let &l:include = '\v\s*(from|import)\s*\zs(\S+\s{-})*\ze($| as)'
let s:sid = expand('<SID>')
let &l:includeexpr = s:sid . 'PyInclude(v:fname)'

function! s:PyInclude(fname) abort
	let parts = split(a:fname, ' import ')
	let l = parts[0]
	if len(parts) > 1
		let r = parts[1]
		let joined = join([l,r], '.')
		let fp = substitute(joined, '\.','/','g') . '.py'
		let found = glob(fp, 1)
		if len(found)
			return found
		endif
		let joined = join([l,'__init__'], '.')
		let fp = substitute(joined, '\.','/','g') . '.py'
		let found = glob(fp, 1)
		if len(found)
			return found
		endif
	endif
	return substitute(l, '\.','/','g') . '.py'
endfunction

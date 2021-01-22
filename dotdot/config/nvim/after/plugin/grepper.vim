if !get(g:, 'loaded_grepper', v:false)
	finish
endif

let g:grepper       = {}
let g:grepper.tools = ["rg"]


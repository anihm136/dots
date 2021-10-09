if !get(g:, "loaded_nvim_lightbulb", v:false)
	finish
endif

autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()

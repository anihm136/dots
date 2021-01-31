if !get(g:, 'loaded_slime', v:false)
	finish
endif

let g:slime_no_mappings = 1

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1

nmap gr <Plug>SlimeMotionSend
xmap gr <Plug>SlimeRegionSend

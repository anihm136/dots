if !get(g:, 'loaded_rooter', v:false)
	finish
endif
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1
let g:rooter_targets = '*'
let g:rooter_cd_cmd = 'lcd'
let g:rooter_patterns = ['.git', 'Makefile', 'package.json', 'Pipfile', 'requirements.txt']


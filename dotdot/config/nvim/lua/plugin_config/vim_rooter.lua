return function()
	vim.g.rooter_change_directory_for_non_project_files = "current"
	vim.g.rooter_resolve_links = true
	vim.g.rooter_silent_chdir = true
	vim.g.rooter_targets = "*"
	vim.g.rooter_cd_cmd = "lcd"
	vim.g.rooter_patterns =
		{ ".git", "Makefile", "package.json", "Pipfile", "requirements.txt" }

end

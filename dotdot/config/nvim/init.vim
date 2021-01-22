if exists('g:started_by_firenvim')
	so ~/.config/nvim/firevimconfig.vim
else
	source ~/.config/nvim/disablePlugins.vim
	source ~/.config/nvim/plugins.vim
	luafile ~/.config/nvim/start.lua
	source ~/.config/nvim/genconfig.vim
endif

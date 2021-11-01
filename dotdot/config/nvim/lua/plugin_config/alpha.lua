return function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	-- Set header
	dashboard.section.header.val =
		{
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}
	-- Set menu
	dashboard.section.buttons.val =
		{
			dashboard.button(
				"e",
				"  > New file",
				":ene <BAR> startinsert <CR>"
			),
			dashboard.button("r", "  > Frecent", ":Telescope frecency<CR>"),
			dashboard.button(
				"d",
				"  > Dotfiles",
				':lua require("telescope_config").edit_dotfiles()<CR>'
			),
			dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
		}
	-- Set footer
	local fortune = require("alpha.fortune")
	dashboard.section.footer.val = fortune()
	-- Send config to alpha
	alpha.setup(dashboard.opts)
	-- Disable folding on alpha buffer
	vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

end

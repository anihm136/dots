require("plugins.bootstrap")

require("lazy").setup("plugins.install", {
	defaults = { lazy = true },
	install = {
		colorscheme = { "catppuccin", "habamax" },
	},
})

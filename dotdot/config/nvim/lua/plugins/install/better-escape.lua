return {
	"jdhao/better-escape.vim",
	event = "InsertEnter",
	init = function()
		vim.g.better_escape_shortcut = "fd"
		vim.g.better_escape_interval = 300
	end,
}

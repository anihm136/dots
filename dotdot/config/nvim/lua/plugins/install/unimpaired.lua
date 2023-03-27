return {
	"anihm136/vim-unimpaired",
	event = "VeryLazy",
	init = function()
		vim.g.unimpaired_mapping = {
			toggles = 0,
			excludes = {
				nextprevs = { "f", "a", "q", "l" },
				keys = { "=P", "[P", "]P" },
			},
		}
	end,
}

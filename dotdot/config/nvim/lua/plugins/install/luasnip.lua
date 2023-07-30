return {
	"L3MON4D3/LuaSnip",
	event = "VeryLazy",
	build = "make install_jsregexp",
	config = function()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end
}

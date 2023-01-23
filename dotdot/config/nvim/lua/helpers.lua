local helpers = {}

-- smart tab completion:
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--	next completion is pum is open
--	expand or next placeholder snippet if available
--	start completion if word is present behind
--	insert <tab> otherwise
helpers.smart_tab = function(fallback)
	local luasnip = require("luasnip")
	local cmp = require("cmp")
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

--	prev completion is pum is open
--	previous snippet placeholder if available
--	do nothing otherwise
helpers.smart_backtab = function(fallback)
	local luasnip = require("luasnip")
	local cmp = require("cmp")
	if cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

_G.helpers = helpers

-- Return char at index if index is a number, else default behavior
getmetatable("").__index = function(str, i)
	if type(i) == "number" then
		return string.sub(str, i, i)
	else
		return string[i]
	end
end

local helpers = {}
local api = vim.api

-- smart tab completion:
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(
		0,
		line - 1,
		line,
		true
	)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes(key, true, true, true),
		mode,
		true
	)
end

--	next completion is pum is open
--	expand or next placeholder snippet from snippy if available
--	start completion if word is present behind
--	insert <tab> otherwise
helpers.smart_tab = function(fallback)
	local snippy = require"snippy"
	local cmp = require"cmp"
	if cmp.visible() then
		cmp.select_next_item()
	elseif snippy.can_expand_or_advance() then
		feedkey('<cmd>lua require("snippy").expand_or_advance()<cr>', "")
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

--	prev completion is pum is open
--	previous snippet placeholder from snippy if available
--	remove <tab> if present
--	do nothing otherwise
helpers.smart_backtab = function(fallback)
	local snippy = require"snippy"
	local cmp = require"cmp"
	if cmp.visible() then
		cmp.select_prev_item()
	elseif snippy.can_jump(-1) then
		feedkey('<cmd>lua require("snippy").previous()<cr>', "")
	elseif api.nvim_get_current_line()[api.nvim_win_get_cursor(0)[2]]:match(
		"[" .. t"<tab>" .. " ]"
	) then
		feedkey("<bs>", "i")
	else
		fallback()
	end
end

-- Add debug print function to global namespace
_G.P = function(v)
	print(vim.inspect(v))
	return v
end

-- Return char at index if index is a number, else default behavior
getmetatable("").__index = function(str, i)
	if type(i) == "number" then
		return string.sub(str, i, i)
	else
		return string[i]
	end
end

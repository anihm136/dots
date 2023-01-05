local map = function(mode, key, action, desc)
	local opts = {
		noremap = true,
		silent = true,
		unique = true,
	}
	if desc ~= nil then
		opts.desc = desc
	end
	vim.keymap.set(mode, key, action, opts)
end

local map2 = function(mode, key, action, desc)
	local opts = {
		noremap = true,
		unique = true,
	}
	if desc ~= nil then
		opts.desc = desc
	end
	vim.keymap.set(mode, key, action, opts)
end

local mape = function(mode, key, action, desc)
	local opts = {
		noremap = true,
		silent = true,
		unique = true,
		expr = true,
	}
	if desc ~= nil then
		opts.desc = desc
	end
	vim.keymap.set(mode, key, action, opts)
end

local mape2 = function(mode, key, action, desc)
	local opts = {
		noremap = true,
		unique = true,
		expr = true,
	}
	if desc ~= nil then
		opts.desc = desc
	end
	vim.keymap.set(mode, key, action, opts)
end

vim.g.mapleader = " "

-- Working with files
map("n", "<leader>fs", "<cmd>w<cr>", "Save current buffer")
map("n", "<leader>fS", "<cmd>wa!<cr>", "Save all buffers")
map2("n", "<leader>e", [[:edit <c-r>=fnameescape(expand("%:p:h"))<cr>/]], "Edit file in current directory")

-- Editing
map("x", "o", "$h") -- select to end of line
mape("x", "p", function()
	return string.format('pgv"%sy', vim.v.register)
end) -- keep contents of register when pasting over visual selection
-- -- Map original behavior of 'w' motion to 'o'
map("o", "io", "iw")
map("o", "ao", "aw")

-- Navigation
-- Sane defaults for navigating command-line completions
mape2("c", "<up>", function()
	return vim.fn.pumvisible() == 1 and "<c-p>" or "<up>"
end)
mape2("c", "<down>", function()
	return vim.fn.pumvisible() == 1 and "<c-n>" or "<down>"
end)
mape2("c", "<left>", function()
	return vim.fn.pumvisible() == 1 and "<up>" or "<left>"
end)
mape2("c", "<right>", function()
	return vim.fn.pumvisible() == 1 and "<down>" or "<right>"
end)
-- Avoid mistaken press of S-up/down after visual line selection
map("x", "<s-up>", "<up>")
map("x", "<s-down>", "<down>")

-- Text objects
map("x", "ag", "<esc>GVgg") -- whole buffer
map("o", "ag", ":<c-u>normal vag<cr><c-o>")

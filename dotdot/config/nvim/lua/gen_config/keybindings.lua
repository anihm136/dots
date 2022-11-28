local map = function(mode, key, action)
	vim.keymap.set(mode, key, action, {
		noremap = true,
		silent = true,
		unique = true,
	})
end

local map2 = function(mode, key, action)
	vim.keymap.set(mode, key, action, {
		noremap = true,
		unique = true,
	})
end

local mape = function(mode, key, action)
	vim.keymap.set(mode, key, action, {
		noremap = true,
		silent = true,
		unique = true,
		expr = true,
	})
end

local mape2 = function(mode, key, action)
	vim.keymap.set(mode, key, action, {
		noremap = true,
		unique = true,
		expr = true,
	})
end

vim.g.mapleader = " "
 
-- Working with files
map("n", "<leader>fs", "<cmd>w<cr>") -- save current buffer
map("n", "<leader>fS", "<cmd>wa!<cr>") -- save all buffers
map2("n", "<leader>e", [[:edit <c-r>=fnameescape(expand("%:p:h"))<cr>/]]) -- edit file in current dir

-- -- Editing
map("x", "o", "$h") -- select to end of line
mape("x", "p", function() return string.format("pgv\"%sy", vim.v.register) end) -- keep contents of register when pasting over visual selection
-- -- Map original behavior of 'w' motion to 'o'
map("o", "io", "iw")
map("o", "ao", "aw")

-- Navigation
-- Sane defaults for navigating command-line completions
mape2("c", "<up>", function() return vim.fn.pumvisible() == 1 and "<c-p>" or "<up>" end)
mape2("c", "<down>", function() return vim.fn.pumvisible() == 1 and "<c-n>" or "<down>" end)
mape2("c", "<left>", function() return vim.fn.pumvisible() == 1 and "<up>" or "<left>" end)
mape2("c", "<right>", function() return vim.fn.pumvisible() == 1 and "<down>" or "<right>" end)
-- Avoid mistaken press of S-up/down after visual line selection
map("x", "<s-up>", "<up>")
map("x", "<s-down>", "<down>")

-- Text objects
map("x", "ag", "<esc>GVgg")
map("o", "ag", ":<c-u>normal vag<cr><c-o>")

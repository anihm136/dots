-- Buffer and window stuff
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = { "useopen", "usetab" }

-- Backup stuff
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.swapfile = false

-- List chars
vim.opt.list = true
vim.opt.listchars = { eol = "↲", tab = "» ", trail = "𝁢", extends = "…", precedes = "…", conceal = "┊" }

-- Tab-related stuff
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 0
vim.opt.shiftround = true

-- Search-related stuff
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Side columns
vim.opt.signcolumn = "auto:2-9"
vim.opt.number = true
vim.opt.relativenumber = true

-- Misc
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = { "unnamedplus" }
vim.opt.updatetime = 400
vim.opt.cursorline = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.timeoutlen = 300
vim.opt.linebreak = true

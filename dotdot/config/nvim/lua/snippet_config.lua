local snippets = require"snippets"
local U = require"snippets.utils"

local snips = {}

snips._global = {
	copyright = U.force_comment[[Copyright (C) ${1=vim.g.snips_author} ${=os.date("%Y")}]],
	todo = U.force_comment[[TODO(${1=vim.g.snips_author}): ]],
	fixme = U.force_comment[[FIXME(${1=vim.g.snips_author}): ]],
	note = U.force_comment[[NOTE(${1=vim.g.snips_author}): ]],
	uname = function()
		return vim.loop.os_uname().sysname
	end,
	date = function()
		return os.date()
	end,
	epoch = function()
		return os.time()
	end,
}
snips.c          = require("mysnippets/c").get_snippets()
snips.cpp        = require("mysnippets/cpp").get_snippets()
snips.cmake      = require("mysnippets/cmake").get_snippets()
snips.go         = require("mysnippets/go").get_snippets()
snips.html       = require("mysnippets/html").get_snippets()
snips.htmldjango = require("mysnippets/htmldjango").get_snippets()
snips.java       = require("mysnippets/java").get_snippets() -- WIP
snips.javascript = require("mysnippets/javascript").get_snippets() -- WIP
snips.lua        = require("mysnippets/lua").get_snippets()
snips.make       = require("mysnippets/make").get_snippets()
snips.markdown   = require("mysnippets/markdown").get_snippets() -- WIP
snips.python     = require("mysnippets/python").get_snippets()
snips.rust       = require("mysnippets/rust").get_snippets() -- WIP
snips.sh         = require("mysnippets/sh").get_snippets()
snips.zsh        = require("mysnippets/zsh").get_snippets()
snips.vim        = require("mysnippets/vim").get_snippets()

snippets.snippets = snips

vim.g.snips_author = "anihm136"
vim.g.snips_email = "anihm136@gmail.com"
vim.g.snips_github = "anihm136"

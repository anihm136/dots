local indent = require"snippets.utils".match_indentation

local zsh = require('mysnippets.sh').get_snippets()
zsh["#!"] = [[#! /usr/bin/env zsh]]

local m = {}

m.get_snippets = function()
	return zsh
end

return m

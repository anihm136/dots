local indent = require'snippets.utils'.match_indentation

local name = {
}

local m = {}

m.get_snippets = function()
  return name
end

return m

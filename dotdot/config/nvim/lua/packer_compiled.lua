-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/anihm136/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/anihm136/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/anihm136/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/anihm136/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/anihm136/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  Despacio = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/Despacio"
  },
  ["Dockerfile.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["auto-session"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/auto-session"
  },
  ["better-escape.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/better-escape.vim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  ["cmp-snippy"] = {
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-snippy/after/plugin/cmp_snippy.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-snippy"
  },
  ["csv.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim"
  },
  diffconflicts = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/diffconflicts"
  },
  ["emmet-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  ["equinusocio-material.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/equinusocio-material.vim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n˚\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\17watch_gitdir\1\0\1\rinterval\3–\15\fkeymaps\1\0\1\20update_debounce\3Ù\3\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\3\vbuffer\2\17n <leader>gl4<cmd>lua require\"gitsigns\".blame_line(true)<CR>\fnoremap\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["gtags.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/gtags.vim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["importmagic.nvim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/importmagic.nvim"
  },
  ["indent-o-matic"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/indent-o-matic"
  },
  kommentary = {
    config = { "\27LJ\2\nø\2\2\0\f\0\v\2+4\0\3\0G\1\0\0?\1\0\0:\1\1\0:\2\2\0006\3\0\0009\3\1\0039\3\2\3)\5\0\0\23\6\1\1\18\a\2\0+\b\1\0B\3\5\0026\4\0\0009\4\1\0049\4\3\4)\6\0\0\18\a\2\0\18\b\2\0+\t\1\0\18\n\3\0B\4\6\0016\4\0\0009\4\1\0049\4\4\0046\6\0\0009\6\1\0069\6\5\6'\b\6\0+\t\2\0+\n\1\0+\v\2\0B\6\5\2'\a\a\0+\b\2\0B\4\4\0016\4\b\0'\6\t\0B\4\2\0029\4\n\4G\6\0\0A\4\0\1K\0\1\0\27toggle_comment_singles\15kommentary\frequire\6n\n<Esc>\27nvim_replace_termcodes\18nvim_feedkeys\23nvim_buf_set_lines\23nvim_buf_get_lines\bapi\bvim\3ÄÄ¿ô\4\2Ω\1\2\0\n\0\t\1\0254\0\3\0G\1\0\0?\1\0\0:\1\1\0:\2\2\0006\3\0\0009\3\1\0039\3\2\0036\5\3\0\18\a\1\0B\5\2\2'\6\4\0006\a\3\0\18\t\2\0B\a\2\2'\b\5\0&\5\b\5B\3\2\0016\3\6\0'\5\a\0B\3\2\0029\3\b\3G\5\0\0A\3\0\1K\0\1\0\27toggle_comment_singles\15kommentary\frequire\6y\6,\rtostring\17nvim_command\bapi\bvim\3ÄÄ¿ô\4°\5\1\0\b\0\27\0>6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0005\4\4\0B\1\3\0016\1\5\0003\2\a\0=\2\6\0016\1\5\0003\2\t\0=\2\b\0019\1\n\0'\3\v\0'\4\f\0009\5\r\0009\5\14\0054\6\0\0006\a\b\0B\1\6\0019\1\n\0'\3\15\0'\4\16\0009\5\r\0009\5\17\0055\6\18\0006\a\b\0B\1\6\0019\1\n\0'\3\15\0'\4\19\0009\5\r\0009\5\20\0055\6\21\0006\a\b\0B\1\6\0019\1\n\0'\3\v\0'\4\22\0009\5\r\0009\5\14\0054\6\0\0006\a\6\0B\1\6\0019\1\n\0'\3\15\0'\4\23\0009\5\r\0009\5\17\0055\6\24\0006\a\6\0B\1\6\0019\1\n\0'\3\15\0'\4\25\0009\5\r\0009\5\20\0055\6\26\0006\a\6\0B\1\6\1K\0\1\0\1\0\1\texpr\2%kommentary_comment_and_duplicate\1\0\1\texpr\2,kommentary_comment_and_duplicate_motion,kommentary_comment_and_duplicate_visual\1\0\1\texpr\2\tline kommentary_comment_and_yank\1\0\1\texpr\2\vmotion'kommentary_comment_and_yank_motion\6n\vvisual\fcontext'kommentary_comment_and_yank_visual\6v\15add_keymap\0\21comment_and_yank\0\26comment_and_duplicate\a_G\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/kommentary"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/lexima.vim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/lightspeed.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nR\0\0\3\0\3\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0B\0\2\2)\1x\0\0\1\0\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\23nvim_win_get_width\bapi\bvim\25\0\0\2\1\0\0\4-\0\0\0B\0\1\2\19\0\0\0L\0\2\0\0¿\18\0\0\1\0\1\0\2'\0\0\0L\0\2\0\a%=∂\2\0\0\r\0\15\2,'\0\0\0006\1\1\0009\1\2\0019\1\3\1)\3\0\0'\4\4\0B\1\3\0026\2\1\0009\2\5\0029\2\6\2B\2\1\0026\3\a\0\18\5\2\0B\3\2\2\v\3\0\0X\3\1ÄL\0\2\0006\3\b\0\18\5\2\0B\3\2\4X\6\20Ä9\b\t\a9\b\n\b9\t\v\a\a\t\f\0X\t\3Ä\21\t\2\0\t\t\0\0X\t\fÄ\15\0\b\0X\t\nÄ6\t\1\0009\t\r\t9\t\14\t\18\v\b\0\18\f\1\0B\t\3\2\b\t\1\0X\t\2Ä9\t\v\aL\t\2\0E\6\3\3R\6ÍL\0\2\0\nindex\afn\befm\tname\14filetypes\vconfig\vipairs\tnext\23get_active_clients\blsp\rfiletype\24nvim_buf_get_option\bapi\bvim\18No Active Lsp\2˛ˇˇˇ\31·\6\1\0\b\0)\0M3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\t\0005\4\4\0005\5\5\0=\5\6\0045\5\a\0=\5\b\4=\4\n\0035\4\f\0004\5\3\0005\6\v\0>\6\1\5=\5\r\0044\5\3\0005\6\14\0>\6\1\5=\5\15\0044\5\5\0005\6\16\0=\0\17\6>\6\1\0055\6\18\0003\a\19\0=\a\17\6>\6\2\0055\6\21\0003\a\20\0>\a\1\6>\6\3\0055\6\23\0003\a\22\0>\a\1\6>\6\4\5=\5\24\0044\5\4\0005\6\25\0=\0\17\6>\6\1\0055\6\26\0=\0\17\6>\6\2\0055\6\27\0>\6\3\5=\5\28\0045\5\29\0=\5\30\0044\5\3\0005\6\31\0>\6\1\0055\6 \0=\0\17\6>\6\2\5=\5!\4=\4\"\0035\4#\0004\5\0\0=\5\r\0044\5\0\0=\5\15\0045\5$\0=\5\24\0045\5%\0=\5\28\0044\5\0\0=\5\30\0044\5\0\0=\5!\4=\4&\0035\4'\0=\4(\3B\1\2\0012\0\0ÄK\0\1\0\15extensions\1\3\0\0\14nvim-tree\rquickfix\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\1\0\rlocation\ncolor\14lualine_z\1\2\1\0\rprogress\ncolor\14lualine_z\14lualine_y\1\2\0\0\tdiff\14lualine_x\1\2\0\0\rfiletype\1\2\0\0\15fileformat\1\2\0\0\rencoding\14lualine_c\1\0\1\ticon\14ÔÇÖ  LSP:\0\1\0\1\14separator\5\0\0\1\2\2\0\rfilename\16file_status\2\14separator\5\14condition\1\2\3\0\rfilename\tpath\3\1\14separator\5\16file_status\2\14lualine_b\1\2\1\0\vbranch\ticon\bÓÇ†\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\foptions\1\0\0\25component_separators\1\3\0\0\bÓÇ±\bÓÇ≥\23section_separators\1\3\0\0\bÓÇ∞\bÓÇ≤\1\0\2\ntheme\tauto\18icons_enabled\2\nsetup\flualine\frequire\0\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  miramare = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/miramare"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nightfox.nvim"
  },
  ["nvim-cmp"] = {
    after = { "cmp-buffer", "cmp-path", "cmp-snippy" },
    config = { "\27LJ\2\nF\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19expand_snippet\vsnippy\frequireŒ\4\1\0\v\0&\0C6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0005\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\0055\6\f\0009\a\n\0009\a\v\a)\t¸ˇB\a\2\2=\a\r\0069\a\n\0009\a\v\a)\t\4\0B\a\2\2=\a\14\0069\a\n\0009\a\15\aB\a\1\2=\a\16\0069\a\n\0009\a\17\aB\a\1\2=\a\18\0069\a\n\0009\a\19\a5\t\20\0B\a\2\2=\a\21\0069\a\n\0009\t\22\0025\n\23\0B\a\3\2=\a\24\0069\a\n\0009\t\25\0025\n\26\0B\a\3\2=\a\27\6=\6\n\0054\6\4\0005\a\28\0>\a\1\0065\a\29\0>\a\2\0065\a\30\0>\a\3\6=\6\31\0055\6 \0=\6!\0055\6#\0009\a\"\1B\a\1\2=\a$\6=\6%\5B\3\2\1K\0\1\0\15formatting\vformat\1\0\0\15cmp_format\15completion\1\0\1\17autocomplete\1\fsources\1\0\1\tname\vsnippy\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\f<S-Tab>\1\3\0\0\6i\6s\18smart_backtab\n<Tab>\1\3\0\0\6i\6s\14smart_tab\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fhelpers\flspkind\bcmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\5\0\0\bcss\15javascript\bvim\thtml\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb"
  },
  ["nvim-lsp-smag"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-lsp-smag"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-snippy"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-snippy"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n¿\3\0\0\6\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\v\0005\4\6\0005\5\a\0=\5\b\0045\5\t\0=\5\n\4=\4\f\0035\4\r\0005\5\14\0=\5\15\4=\4\16\3=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\2B\0\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\vindent\1\0\1\venable\1\16textobjects\vselect\fkeymaps\1\0\4\aac\17@class.outer\aif\20@function.inner\aic\17@class.inner\aaf\20@function.outer\1\0\1\venable\2\tswap\1\0\0\18swap_previous\1\0\1\ag<\21@parameter.inner\14swap_next\1\0\1\ag>\21@parameter.inner\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["rainbow_parentheses.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/rainbow_parentheses.vim"
  },
  ["session-lens"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/session-lens"
  },
  ["splitjoin.vim"] = {
    keys = { { "", "gJ" }, { "", "gS" } },
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["statusline-themer"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/statusline-themer"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tempus-themes-vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/tempus-themes-vim"
  },
  ["tmux.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim/"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-apathy"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-cmake-syntax"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-cmake-syntax"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-cool"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dogrun"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-dogrun"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-git"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-git"
  },
  ["vim-gruvbit"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-gruvbit"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-jinja"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jinja"
  },
  ["vim-jsonc"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-octave"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-sandwich"] = {
    loaded = true,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  },
  ["vim-search-pulse"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-search-pulse"
  },
  ["vim-slime"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-slime"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-solarized8"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-solarized8"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-sxhkdrc"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-sxhkdrc"
  },
  ["vim-systemd-syntax"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator"
  },
  ["vim-tridactyl"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-tridactyl"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-unimpaired"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  vimade = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vimade"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim/"
time([[Runtimepath customization]], false)
-- Setup for: vim-sandwich
time([[Setup for vim-sandwich]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0000runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0", "setup", "vim-sandwich")
time([[Setup for vim-sandwich]], false)
time([[packadd for vim-sandwich]], true)
vim.cmd [[packadd vim-sandwich]]
time([[packadd for vim-sandwich]], false)
-- Setup for: kommentary
time([[Setup for kommentary]], true)
try_loadstring("\27LJ\2\nD\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\1\0=\1\2\0K\0\1\0'kommentary_create_default_mappings\6g\bvim\0", "setup", "kommentary")
time([[Setup for kommentary]], false)
time([[packadd for kommentary]], true)
vim.cmd [[packadd kommentary]]
time([[packadd for kommentary]], false)
-- Setup for: better-escape.vim
time([[Setup for better-escape.vim]], true)
try_loadstring("\27LJ\2\nb\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\4\0K\0\1\0\27better_escape_interval\afd\27better_escape_shortcut\6g\bvim\0", "setup", "better-escape.vim")
time([[Setup for better-escape.vim]], false)
-- Setup for: nvim-lightbulb
time([[Setup for nvim-lightbulb]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\26loaded_nvim_lightbulb\6g\bvim\0", "setup", "nvim-lightbulb")
time([[Setup for nvim-lightbulb]], false)
time([[packadd for nvim-lightbulb]], true)
vim.cmd [[packadd nvim-lightbulb]]
time([[packadd for nvim-lightbulb]], false)
-- Setup for: vim-unimpaired
time([[Setup for vim-unimpaired]], true)
try_loadstring("\27LJ\2\nç\1\0\0\4\0\n\0\v6\0\0\0009\0\1\0005\1\3\0005\2\5\0005\3\4\0=\3\6\0025\3\a\0=\3\b\2=\2\t\1=\1\2\0K\0\1\0\rexcludes\tkeys\1\4\0\0\a=P\a[P\a]P\14nextprevs\1\0\0\1\5\0\0\6f\6a\6q\6l\1\0\1\ftoggles\3\0\23unimpaired_mapping\6g\bvim\0", "setup", "vim-unimpaired")
time([[Setup for vim-unimpaired]], false)
time([[packadd for vim-unimpaired]], true)
vim.cmd [[packadd vim-unimpaired]]
time([[packadd for vim-unimpaired]], false)
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\31tmux_navigator_no_mappings\6g\bvim\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
time([[packadd for vim-tmux-navigator]], true)
vim.cmd [[packadd vim-tmux-navigator]]
time([[packadd for vim-tmux-navigator]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nR\0\0\3\0\3\0\f6\0\0\0009\0\1\0009\0\2\0)\2\0\0B\0\2\2)\1x\0\0\1\0\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\23nvim_win_get_width\bapi\bvim\25\0\0\2\1\0\0\4-\0\0\0B\0\1\2\19\0\0\0L\0\2\0\0¿\18\0\0\1\0\1\0\2'\0\0\0L\0\2\0\a%=∂\2\0\0\r\0\15\2,'\0\0\0006\1\1\0009\1\2\0019\1\3\1)\3\0\0'\4\4\0B\1\3\0026\2\1\0009\2\5\0029\2\6\2B\2\1\0026\3\a\0\18\5\2\0B\3\2\2\v\3\0\0X\3\1ÄL\0\2\0006\3\b\0\18\5\2\0B\3\2\4X\6\20Ä9\b\t\a9\b\n\b9\t\v\a\a\t\f\0X\t\3Ä\21\t\2\0\t\t\0\0X\t\fÄ\15\0\b\0X\t\nÄ6\t\1\0009\t\r\t9\t\14\t\18\v\b\0\18\f\1\0B\t\3\2\b\t\1\0X\t\2Ä9\t\v\aL\t\2\0E\6\3\3R\6ÍL\0\2\0\nindex\afn\befm\tname\14filetypes\vconfig\vipairs\tnext\23get_active_clients\blsp\rfiletype\24nvim_buf_get_option\bapi\bvim\18No Active Lsp\2˛ˇˇˇ\31·\6\1\0\b\0)\0M3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\t\0005\4\4\0005\5\5\0=\5\6\0045\5\a\0=\5\b\4=\4\n\0035\4\f\0004\5\3\0005\6\v\0>\6\1\5=\5\r\0044\5\3\0005\6\14\0>\6\1\5=\5\15\0044\5\5\0005\6\16\0=\0\17\6>\6\1\0055\6\18\0003\a\19\0=\a\17\6>\6\2\0055\6\21\0003\a\20\0>\a\1\6>\6\3\0055\6\23\0003\a\22\0>\a\1\6>\6\4\5=\5\24\0044\5\4\0005\6\25\0=\0\17\6>\6\1\0055\6\26\0=\0\17\6>\6\2\0055\6\27\0>\6\3\5=\5\28\0045\5\29\0=\5\30\0044\5\3\0005\6\31\0>\6\1\0055\6 \0=\0\17\6>\6\2\5=\5!\4=\4\"\0035\4#\0004\5\0\0=\5\r\0044\5\0\0=\5\15\0045\5$\0=\5\24\0045\5%\0=\5\28\0044\5\0\0=\5\30\0044\5\0\0=\5!\4=\4&\0035\4'\0=\4(\3B\1\2\0012\0\0ÄK\0\1\0\15extensions\1\3\0\0\14nvim-tree\rquickfix\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\1\0\rlocation\ncolor\14lualine_z\1\2\1\0\rprogress\ncolor\14lualine_z\14lualine_y\1\2\0\0\tdiff\14lualine_x\1\2\0\0\rfiletype\1\2\0\0\15fileformat\1\2\0\0\rencoding\14lualine_c\1\0\1\ticon\14ÔÇÖ  LSP:\0\1\0\1\14separator\5\0\0\1\2\2\0\rfilename\16file_status\2\14separator\5\14condition\1\2\3\0\rfilename\tpath\3\1\14separator\5\16file_status\2\14lualine_b\1\2\1\0\vbranch\ticon\bÓÇ†\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\foptions\1\0\0\25component_separators\1\3\0\0\bÓÇ±\bÓÇ≥\23section_separators\1\3\0\0\bÓÇ∞\bÓÇ≤\1\0\2\ntheme\tauto\18icons_enabled\2\nsetup\flualine\frequire\0\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0", "config", "vim-matchup")
time([[Config for vim-matchup]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n˚\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\17watch_gitdir\1\0\1\rinterval\3–\15\fkeymaps\1\0\1\20update_debounce\3Ù\3\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\3\vbuffer\2\17n <leader>gl4<cmd>lua require\"gitsigns\".blame_line(true)<CR>\fnoremap\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n¿\3\0\0\6\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\v\0005\4\6\0005\5\a\0=\5\b\0045\5\t\0=\5\n\4=\4\f\0035\4\r\0005\5\14\0=\5\15\4=\4\16\3=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\2B\0\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\vindent\1\0\1\venable\1\16textobjects\vselect\fkeymaps\1\0\4\aac\17@class.outer\aif\20@function.inner\aic\17@class.inner\aaf\20@function.outer\1\0\1\venable\2\tswap\1\0\0\18swap_previous\1\0\1\ag<\21@parameter.inner\14swap_next\1\0\1\ag>\21@parameter.inner\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\2\nø\2\2\0\f\0\v\2+4\0\3\0G\1\0\0?\1\0\0:\1\1\0:\2\2\0006\3\0\0009\3\1\0039\3\2\3)\5\0\0\23\6\1\1\18\a\2\0+\b\1\0B\3\5\0026\4\0\0009\4\1\0049\4\3\4)\6\0\0\18\a\2\0\18\b\2\0+\t\1\0\18\n\3\0B\4\6\0016\4\0\0009\4\1\0049\4\4\0046\6\0\0009\6\1\0069\6\5\6'\b\6\0+\t\2\0+\n\1\0+\v\2\0B\6\5\2'\a\a\0+\b\2\0B\4\4\0016\4\b\0'\6\t\0B\4\2\0029\4\n\4G\6\0\0A\4\0\1K\0\1\0\27toggle_comment_singles\15kommentary\frequire\6n\n<Esc>\27nvim_replace_termcodes\18nvim_feedkeys\23nvim_buf_set_lines\23nvim_buf_get_lines\bapi\bvim\3ÄÄ¿ô\4\2Ω\1\2\0\n\0\t\1\0254\0\3\0G\1\0\0?\1\0\0:\1\1\0:\2\2\0006\3\0\0009\3\1\0039\3\2\0036\5\3\0\18\a\1\0B\5\2\2'\6\4\0006\a\3\0\18\t\2\0B\a\2\2'\b\5\0&\5\b\5B\3\2\0016\3\6\0'\5\a\0B\3\2\0029\3\b\3G\5\0\0A\3\0\1K\0\1\0\27toggle_comment_singles\15kommentary\frequire\6y\6,\rtostring\17nvim_command\bapi\bvim\3ÄÄ¿ô\4°\5\1\0\b\0\27\0>6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0005\4\4\0B\1\3\0016\1\5\0003\2\a\0=\2\6\0016\1\5\0003\2\t\0=\2\b\0019\1\n\0'\3\v\0'\4\f\0009\5\r\0009\5\14\0054\6\0\0006\a\b\0B\1\6\0019\1\n\0'\3\15\0'\4\16\0009\5\r\0009\5\17\0055\6\18\0006\a\b\0B\1\6\0019\1\n\0'\3\15\0'\4\19\0009\5\r\0009\5\20\0055\6\21\0006\a\b\0B\1\6\0019\1\n\0'\3\v\0'\4\22\0009\5\r\0009\5\14\0054\6\0\0006\a\6\0B\1\6\0019\1\n\0'\3\15\0'\4\23\0009\5\r\0009\5\17\0055\6\24\0006\a\6\0B\1\6\0019\1\n\0'\3\15\0'\4\25\0009\5\r\0009\5\20\0055\6\26\0006\a\6\0B\1\6\1K\0\1\0\1\0\1\texpr\2%kommentary_comment_and_duplicate\1\0\1\texpr\2,kommentary_comment_and_duplicate_motion,kommentary_comment_and_duplicate_visual\1\0\1\texpr\2\tline kommentary_comment_and_yank\1\0\1\texpr\2\vmotion'kommentary_comment_and_yank_motion\6n\vvisual\fcontext'kommentary_comment_and_yank_visual\6v\15add_keymap\0\21comment_and_yank\0\26comment_and_duplicate\a_G\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> gS <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gJ <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gJ", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType systemd ++once lua require("packer.load")({'vim-systemd-syntax'}, { ft = "systemd" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'importmagic.nvim', 'vim-slime'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType tmux ++once lua require("packer.load")({'tmux.vim'}, { ft = "tmux" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType cmake ++once lua require("packer.load")({'vim-cmake-syntax'}, { ft = "cmake" }, _G.packer_plugins)]]
vim.cmd [[au FileType jsonc ++once lua require("packer.load")({'vim-jsonc'}, { ft = "jsonc" }, _G.packer_plugins)]]
vim.cmd [[au FileType csv ++once lua require("packer.load")({'csv.vim'}, { ft = "csv" }, _G.packer_plugins)]]
vim.cmd [[au FileType Dockerfile ++once lua require("packer.load")({'Dockerfile.vim'}, { ft = "Dockerfile" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua', 'vim-jinja', 'emmet-vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-colorizer.lua', 'emmet-vim'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'emmet-vim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'emmet-vim'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'emmet-vim'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType php ++once lua require("packer.load")({'emmet-vim'}, { ft = "php" }, _G.packer_plugins)]]
vim.cmd [[au FileType htmljinja ++once lua require("packer.load")({'emmet-vim'}, { ft = "htmljinja" }, _G.packer_plugins)]]
vim.cmd [[au FileType octave ++once lua require("packer.load")({'vim-octave'}, { ft = "octave" }, _G.packer_plugins)]]
vim.cmd [[au FileType vue ++once lua require("packer.load")({'emmet-vim'}, { ft = "vue" }, _G.packer_plugins)]]
vim.cmd [[au FileType htmldjango ++once lua require("packer.load")({'vim-jinja', 'emmet-vim'}, { ft = "htmldjango" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'better-escape.vim', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim//ftdetect/tmux.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim//ftdetect/tmux.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim//ftdetect/tmux.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax/ftdetect/systemd.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax/ftdetect/systemd.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax/ftdetect/systemd.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave/ftdetect/octave.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave/ftdetect/octave.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave/ftdetect/octave.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
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
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/Despacio",
    url = "https://github.com/AlessandroYorba/Despacio"
  },
  ["Dockerfile.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim",
    url = "https://github.com/ekalinin/Dockerfile.vim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n�\v\0\0\t\0\28\00166\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\2\4\0025\3\6\0=\3\5\0029\2\3\0019\2\a\0024\3\5\0009\4\b\1'\6\t\0'\a\n\0'\b\v\0B\4\4\2>\4\1\0039\4\b\1'\6\f\0'\a\r\0'\b\14\0B\4\4\2>\4\2\0039\4\b\1'\6\15\0'\a\16\0'\b\17\0B\4\4\2>\4\3\0039\4\b\1'\6\18\0'\a\19\0'\b\20\0B\4\4\0?\4\0\0=\3\5\0026\2\0\0'\4\21\0B\2\2\0029\3\3\0019\3\22\3\18\4\2\0B\4\1\2=\4\5\0039\3\23\0009\5\24\1B\3\2\0016\3\25\0009\3\26\3'\5\27\0B\3\2\1K\0\1\0006    autocmd FileType alpha setlocal nofoldenable\n\bcmd\bvim\topts\nsetup\vfooter\18alpha.fortune\f:qa<CR>\21  > Quit NVIM\6q9:lua require(\"telescope_config\").edit_dotfiles()<CR>\20  > Dotfiles\6d\28:Telescope frecency<CR>\19  > Frecent\6r :ene <BAR> startinsert <CR>\20  > New file\6e\vbutton\fbuttons\1\t\0\0:                                                     �\1  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ �\1  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ �\1  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ �\1  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ �\1  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ �\1  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ :                                                     \bval\vheader\fsection\27alpha.themes.dashboard\nalpha\frequire\t����\4\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["auto-pairs"] = {
    config = { "\27LJ\2\n�\1\0\0\2\0\b\0\0216\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0006\0\0\0009\0\1\0+\1\1\0=\1\a\0K\0\1\0\28AutoPairsCompatibleMaps\28AutoPairsMultilineClose\5*AutoPairsShortcutToggleMultilineClose!AutoPairsCompleteOnlyOnSpace\19AutoPairsMapBS\6g\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/LunarWatcher/auto-pairs"
  },
  ["better-escape.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/better-escape.vim",
    url = "https://github.com/jdhao/better-escape.vim"
  },
  ["cmp-buffer"] = {
    after = { "nvim-cmp" },
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after = { "nvim-cmp" },
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after = { "nvim-cmp" },
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-snippy"] = {
    after = { "nvim-cmp" },
    after_files = { "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-snippy/after/plugin/cmp_snippy.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/cmp-snippy",
    url = "https://github.com/dcampos/cmp-snippy"
  },
  ["csv.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim",
    url = "https://github.com/chrisbra/csv.vim"
  },
  diffconflicts = {
    commands = { "DiffConflicts", "DiffConflictsShowHistory", "DiffConflictsWithHistory" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/diffconflicts",
    url = "https://github.com/whiteinge/diffconflicts"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["equinusocio-material.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/equinusocio-material.vim",
    url = "https://github.com/chuling/equinusocio-material.vim"
  },
  ["far.vim"] = {
    commands = { "Far", "Farp", "Farr", "Farf" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/far.vim",
    url = "https://github.com/brooth/far.vim"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfeline\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/feline.nvim",
    url = "https://github.com/famiu/feline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\17watch_gitdir\1\0\1\rinterval\3�\15\fkeymaps\1\0\1\20update_debounce\3�\3\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'\texpr\2\1\0\3\fnoremap\2\17n <leader>gl4<cmd>lua require\"gitsigns\".blame_line(true)<cr>\vbuffer\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gtags.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/gtags.vim",
    url = "https://github.com/fedorenchik/gtags.vim"
  },
  harpoon = {
    config = { "\27LJ\2\n�\1\0\0\b\0\t\0\0176\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1K\0\1\0004<cmd>lua require(\"harpoon.mark\").add_file()<cr>\15<leader>pa;<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<cr>\15<leader>ph\6n\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n*\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\t<cr>\14<cmd>lua �\2\1\0\n\0\14\0+6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\1\6\0003\2\a\0\18\3\0\0'\5\b\0'\6\t\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\b\0'\6\v\0\18\a\2\0'\t\f\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\r\0'\6\t\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\r\0'\6\v\0\18\a\2\0'\t\f\0B\a\2\2\18\b\1\0B\3\5\1K\0\1\0\6x\30require'hop'.hint_lines()\bgsj\30require'hop'.hint_words()\bgsw\6n\0\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["importmagic.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/importmagic.nvim",
    url = "https://github.com/anihm136/importmagic.nvim"
  },
  ["indent-o-matic"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/indent-o-matic",
    url = "https://github.com/Darazaki/indent-o-matic"
  },
  kommentary = {
    config = { "\27LJ\2\n^\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\25update_commentstring&ts_context_commentstring.internal\frequire�\2\2\0\f\0\v\2+4\0\3\0G\1\0\0?\1\0\0:\1\1\0:\2\2\0006\3\0\0009\3\1\0039\3\2\3)\5\0\0\23\6\1\1\18\a\2\0+\b\1\0B\3\5\0026\4\0\0009\4\1\0049\4\3\4)\6\0\0\18\a\2\0\18\b\2\0+\t\1\0\18\n\3\0B\4\6\0016\4\0\0009\4\1\0049\4\4\0046\6\0\0009\6\1\0069\6\5\6'\b\6\0+\t\2\0+\n\1\0+\v\2\0B\6\5\2'\a\a\0+\b\2\0B\4\4\0016\4\b\0'\6\t\0B\4\2\0029\4\n\4G\6\0\0A\4\0\1K\0\1\0\19toggle_comment\15kommentary\frequire\6n\n<Esc>\27nvim_replace_termcodes\18nvim_feedkeys\23nvim_buf_set_lines\23nvim_buf_get_lines\bapi\bvim\3����\4\2�\1\2\0\n\0\t\1\0254\0\3\0G\1\0\0?\1\0\0:\1\1\0:\2\2\0006\3\0\0009\3\1\0039\3\2\0036\5\3\0\18\a\1\0B\5\2\2'\6\4\0006\a\3\0\18\t\2\0B\a\2\2'\b\5\0&\5\b\5B\3\2\0016\3\6\0'\5\a\0B\3\2\0029\3\b\3G\5\0\0A\3\0\1K\0\1\0\19toggle_comment\15kommentary\frequire\6y\6,\rtostring\17nvim_command\bapi\bvim\3����\4�\t\1\0\v\0-\0v6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0005\4\4\0003\5\5\0=\5\6\4B\1\3\0013\1\a\0003\2\b\0009\3\t\0'\5\n\0'\6\v\0009\a\f\0009\a\r\a4\b\0\0\18\t\2\0B\3\6\0019\3\t\0'\5\14\0'\6\15\0009\a\f\0009\a\16\a5\b\17\0\18\t\2\0B\3\6\0019\3\t\0'\5\14\0'\6\18\0009\a\f\0009\a\19\a5\b\20\0\18\t\2\0B\3\6\0019\3\t\0'\5\n\0'\6\21\0009\a\f\0009\a\r\a4\b\0\0\18\t\1\0B\3\6\0019\3\t\0'\5\14\0'\6\22\0009\a\f\0009\a\16\a5\b\23\0\18\t\1\0B\3\6\0019\3\t\0'\5\14\0'\6\24\0009\a\f\0009\a\19\a5\b\25\0\18\t\1\0B\3\6\0016\3\26\0009\3\27\0039\3\28\0035\4\29\0\18\5\3\0'\a\14\0'\b\30\0'\t\31\0\18\n\4\0B\5\5\1\18\5\3\0'\a\14\0'\b \0'\t!\0\18\n\4\0B\5\5\1\18\5\3\0'\a\n\0'\b \0'\t\"\0\18\n\4\0B\5\5\1\18\5\3\0'\a\14\0'\b#\0'\t$\0\18\n\4\0B\5\5\1\18\5\3\0'\a\14\0'\b%\0'\t&\0\18\n\4\0B\5\5\1\18\5\3\0'\a\n\0'\b%\0'\t'\0\18\n\4\0B\5\5\1\18\5\3\0'\a\14\0'\b(\0'\t)\0\18\n\4\0B\5\5\1\18\5\3\0'\a\14\0'\b*\0'\t+\0\18\n\4\0B\5\5\1\18\5\3\0'\a\n\0'\b*\0'\t,\0\18\n\4\0B\5\5\1K\0\1\0002<Plug>kommentary_comment_and_duplicate_visual2<Plug>kommentary_comment_and_duplicate_motion\bgcd+<Plug>kommentary_comment_and_duplicate\tgcdd-<Plug>kommentary_comment_and_yank_visual-<Plug>kommentary_comment_and_yank_motion\bgcy&<Plug>kommentary_comment_and_yank\tgcyy)<Plug>kommentary_visual_default<Esc>$<Plug>kommentary_motion_default\agc\"<Plug>kommentary_line_default\bgcc\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\1\0\1\texpr\2%kommentary_comment_and_duplicate\1\0\1\texpr\2,kommentary_comment_and_duplicate_motion,kommentary_comment_and_duplicate_visual\1\0\1\texpr\2\tline kommentary_comment_and_yank\1\0\1\texpr\2\vmotion'kommentary_comment_and_yank_motion\6n\vvisual\fcontext'kommentary_comment_and_yank_visual\6v\15add_keymap\0\0\18hook_function\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0" },
    keys = { { "", "gc" }, { "", "gcc" }, { "", "gcy" }, { "", "gcyy" }, { "", "gcd" }, { "", "gcdd" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/kommentary",
    url = "https://github.com/anihm136/kommentary"
  },
  ["lightspeed.nvim"] = {
    keys = { { "", "<Plug>Lightspeed_s" }, { "", "<Plug>Lightspeed_S" }, { "", "<Plug>Lightspeed_x" }, { "", "<Plug>Lightspeed_X" }, { "", "<Plug>Lightspeed_f" }, { "", "<Plug>Lightspeed_F" }, { "", "<Plug>Lightspeed_t" }, { "", "<Plug>Lightspeed_T" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  miramare = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/miramare",
    url = "https://github.com/franbach/miramare"
  },
  ["neovim-session-manager"] = {
    config = { "\27LJ\2\n�\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\18autoload_mode\1\0\0\rDisabled\17AutoloadMode\27session_manager.config\nsetup\20session_manager\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/neovim-session-manager",
    url = "https://github.com/Shatur/neovim-session-manager"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n�\4\0\0\t\0 \0U6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\30\0004\4\15\0009\5\3\0009\5\4\0059\5\5\5>\5\1\0049\5\3\0009\5\4\0059\5\6\0059\5\a\0055\a\t\0005\b\b\0=\b\n\aB\5\2\2>\5\2\0049\5\3\0009\5\v\0059\5\f\5>\5\3\0049\5\3\0009\5\v\0059\5\r\5>\5\4\0049\5\3\0009\5\4\0059\5\14\5>\5\5\0049\5\3\0009\5\4\0059\5\15\0059\5\a\0055\a\17\0005\b\16\0=\b\n\aB\5\2\2>\5\6\0049\5\3\0009\5\4\0059\5\18\5>\5\a\0049\5\3\0009\5\v\0059\5\19\5>\5\b\0049\5\3\0009\5\4\0059\5\19\5>\5\t\0049\5\3\0009\5\v\0059\5\20\5>\5\n\0049\5\3\0009\5\4\0059\5\21\0059\5\a\0055\a\23\0005\b\22\0=\b\24\aB\5\2\2>\5\v\0049\5\3\0009\5\v\0059\5\25\0059\5\a\0055\a\27\0005\b\26\0=\b\24\aB\5\2\2>\5\f\0049\5\3\0009\5\4\0059\5\28\5>\5\r\0049\5\3\0009\5\4\0059\5\29\5>\5\14\4=\4\31\3B\1\2\1K\0\1\0\fsources\1\0\0\vstylua\rfourmolu\1\0\0\1\2\0\0\tbash\15shellcheck\20extra_filetypes\1\0\0\1\2\0\0\tbash\nshfmt\bzsh\reslint_d\14prettierd\1\0\0\1\2\0\0\17--style=file\17clang_format\ngofmt\18golangci_lint\vflake8\16diagnostics\15extra_args\1\0\0\1\3\0\0\14--profile\nblack\twith\nisort\nblack\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nF\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19expand_snippet\vsnippy\frequire�\4\1\0\v\0(\0G6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0005\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\0055\6\f\0009\a\n\0009\a\v\a)\t��B\a\2\2=\a\r\0069\a\n\0009\a\v\a)\t\4\0B\a\2\2=\a\14\0069\a\n\0009\a\15\aB\a\1\2=\a\16\0069\a\n\0009\a\17\aB\a\1\2=\a\18\0069\a\n\0009\a\19\a5\t\20\0B\a\2\2=\a\21\0069\a\n\0009\t\22\0025\n\23\0B\a\3\2=\a\24\0069\a\n\0009\t\25\0025\n\26\0B\a\3\2=\a\27\6=\6\n\0054\6\6\0005\a\28\0>\a\1\0065\a\29\0>\a\2\0065\a\30\0>\a\3\0065\a\31\0>\a\4\0065\a \0>\a\5\6=\6!\0055\6\"\0=\6#\0055\6%\0009\a$\1B\a\1\2=\a&\6=\6'\5B\3\2\1K\0\1\0\15formatting\vformat\1\0\0\15cmp_format\15completion\1\0\1\17autocomplete\1\fsources\1\0\1\tname\vsnippy\1\0\1\tname\rnvim_lua\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\f<S-Tab>\1\3\0\0\6i\6s\18smart_backtab\n<Tab>\1\3\0\0\6i\6s\14smart_tab\t<cr>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fhelpers\flspkind\bcmp\frequire\0" },
    load_after = {
      ["cmp-buffer"] = true,
      ["cmp-nvim-lua"] = true,
      ["cmp-path"] = true,
      ["cmp-snippy"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\5\0\0\bcss\15javascript\bvim\thtml\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lsp-smag"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-lsp-smag",
    url = "https://github.com/weilbith/nvim-lsp-smag"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-snippy"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-snippy",
    url = "https://github.com/dcampos/nvim-snippy"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = { "\27LJ\2\n�\1\0\0\b\0\n\0\0166\0\0\0009\0\1\0009\0\2\0005\1\3\0006\2\4\0'\4\5\0B\2\2\0029\2\6\2B\2\1\1\18\2\0\0'\4\a\0'\5\b\0'\6\t\0\18\a\1\0B\2\5\1K\0\1\0\28<cmd>NvimTreeToggle<cr>\14<leader>0\6n\nsetup\14nvim-tree\frequire\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "", "<leader>0" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\4\0\0\6\0\29\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\v\0005\4\6\0005\5\a\0=\5\b\0045\5\t\0=\5\n\4=\4\f\0035\4\r\0005\5\14\0=\5\15\4=\4\16\3=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\0025\3\26\0005\4\27\0=\4\15\3=\3\28\2B\0\2\1K\0\1\0\17textsubjects\1\0\2\6;!textsubjects-container-outer\6.\23textsubjects-smart\1\0\1\venable\2\fmatchup\1\0\1\venable\2\fautotag\1\0\1\venable\2\26context_commentstring\1\0\1\venable\2\vindent\1\0\1\venable\1\16textobjects\vselect\fkeymaps\1\0\4\aaf\20@function.outer\aif\20@function.inner\aac\17@class.outer\aic\17@class.inner\1\0\1\venable\2\tswap\1\0\0\18swap_previous\1\0\1\ag<\21@parameter.inner\14swap_next\1\0\1\ag>\21@parameter.inner\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rainbow_parentheses.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/rainbow_parentheses.vim",
    url = "https://github.com/junegunn/rainbow_parentheses.vim"
  },
  ["splitjoin.vim"] = {
    keys = { { "", "gJ" }, { "", "gS" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/sql.nvim",
    url = "https://github.com/tami5/sql.nvim"
  },
  ["statusline-themer"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/statusline-themer",
    url = "https://github.com/anihm136/statusline-themer"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n*\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\t<cr>\14<cmd>lua �\v\1\0\n\0%\0�\0016\0\0\0009\0\1\0009\0\2\0005\1\3\0003\2\4\0\18\3\0\0'\5\5\0'\6\6\0\18\a\2\0'\t\a\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\b\0\18\a\2\0'\t\a\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\t\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\v\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\f\0\18\a\2\0'\t\r\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\14\0\18\a\2\0'\t\15\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\16\0\18\a\2\0'\t\17\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\18\0\18\a\2\0'\t\19\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\20\0\18\a\2\0'\t\21\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\22\0\18\a\2\0'\t\23\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\24\0\18\a\2\0'\t\23\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\25\0\18\a\2\0'\t\26\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\27\0\18\a\2\0'\t\28\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\29\0\18\a\2\0'\t\30\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\31\0\18\a\2\0'\t \0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6!\0\18\a\2\0'\t\"\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6#\0\18\a\2\0'\t$\0B\a\2\2\18\b\1\0B\3\5\1K\0\1\0008require('telescope_config').lsp_workspace_symbols()\agW7require('telescope_config').lsp_document_symbols()\ag0+require('telescope_config').commands()\14<leader>:-require('session-lens').search_session()\15<leader>ss,require('telescope_config').help_tags()\15<leader>fh)require('telescope_config').curbuf()\15<leader>sb\15<leader>bb*require('telescope_config').buffers()\14<leader>,.require('telescope_config').grep_prompt()\15<leader>rwBrequire('telescope_config').live_grep(vim.fn.expand(\"%:p:h\"))\15<leader>sd,require('telescope_config').live_grep()\15<leader>sp)require('telescope_config').recent()\15<leader>fr0require('telescope_config').edit_dotfiles()\15<leader>fp\14<leader>.Drequire('telescope_config').file_search(vim.fn.expand(\"%:p:h\"))\15<leader>ff\20<leader><space>.require('telescope_config').file_search()\15<leader>pf\6n\0\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tempus-themes-vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/tempus-themes-vim",
    url = "git@gitlab.com:protesilaos/tempus-themes-vim"
  },
  ["tmux.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim/",
    url = "https://github.com/ericpruitt/tmux.vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-abolish"] = {
    commands = { "Abolish", "Subvert" },
    keys = { { "", "crs" }, { "", "crm" }, { "", "crc" }, { "", "cru" }, { "", "cr-" }, { "", "cr." }, { "", "cr " }, { "", "crt" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-apathy",
    url = "https://github.com/tpope/vim-apathy"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-asterisk",
    url = "https://github.com/haya14busa/vim-asterisk"
  },
  ["vim-cmake-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-cmake-syntax",
    url = "https://github.com/pboettch/vim-cmake-syntax"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-dogrun"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-dogrun",
    url = "https://github.com/wadackel/vim-dogrun"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n�\1\0\0\b\0\b\0\0176\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\a\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1K\0\1\0\6n\22<Plug>(EasyAlign)\aga\6x\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-git"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-git",
    url = "https://github.com/tpope/vim-git"
  },
  ["vim-gruvbit"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-gruvbit",
    url = "https://github.com/habamax/vim-gruvbit"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-jsonc"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc",
    url = "https://github.com/kevinoid/vim-jsonc"
  },
  ["vim-llvm"] = {
    config = { "\27LJ\2\n5\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\24llvm_ext_no_mapping\6g\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-llvm",
    url = "https://github.com/rhysd/vim-llvm"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-octave"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave",
    url = "https://github.com/McSinyx/vim-octave"
  },
  ["vim-qf"] = {
    config = { "\27LJ\2\n�\4\0\0\b\0\23\0;6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\0016\2\0\0009\2\19\2+\3\2\0=\3\20\0026\2\0\0009\2\19\2+\3\1\0=\3\21\0026\2\0\0009\2\19\2+\3\1\0=\3\22\2K\0\1\0\25qf_auto_open_loclist\26qf_auto_open_quickfix\25qf_mapping_ack_style\6g\25<Plug>(qf_qf_switch)\t<F3>\31<Plug>(qf_loc_toggle_stay)\t<F4>\30<Plug>(qf_qf_toggle_stay)\t<F5>\28<Plug>(qf_loc_previous)\a[l\24<Plug>(qf_loc_next)\a]l\27<Plug>(qf_qf_previous)\a[q\23<Plug>(qf_qf_next)\a]q\6n\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-quickrun"] = {
    config = { "\27LJ\2\nG\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0( runtime after/plugin/quickrun.vim \bcmd\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-quickrun",
    url = "https://github.com/thinca/vim-quickrun"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\2\n�\2\0\0\2\0\f\0\0256\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0005\1\v\0=\1\n\0K\0\1\0\1\6\0\0\t.git\rMakefile\17package.json\fPipfile\21requirements.txt\20rooter_patterns\blcd\18rooter_cd_cmd\6*\19rooter_targets\24rooter_silent_chdir\25rooter_resolve_links\fcurrent2rooter_change_directory_for_non_project_files\6g\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\2\nO\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0000runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0" },
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-sandwich",
    url = "https://github.com/machakann/vim-sandwich"
  },
  ["vim-search-pulse"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-search-pulse",
    url = "https://github.com/inside/vim-search-pulse"
  },
  ["vim-slime"] = {
    config = { "\27LJ\2\n�\2\0\0\t\0\16\0#6\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1)\2\1\0=\2\4\0016\1\0\0009\1\3\1'\2\6\0=\2\5\0016\1\0\0009\1\3\0015\2\b\0=\2\a\0016\1\0\0009\1\3\1)\2\1\0=\2\t\0015\1\n\0\18\2\0\0)\4\0\0'\5\v\0'\6\f\0'\a\r\0\18\b\1\0B\2\6\1\18\2\0\0)\4\0\0'\5\14\0'\6\f\0'\a\15\0\18\b\1\0B\2\6\1K\0\1\0\26<Plug>SlimeRegionSend\6x\26<Plug>SlimeMotionSend\agr\6n\1\0\1\vsilent\2\27slime_dont_ask_default\1\0\2\16target_pane\v{last}\16socket_name\fdefault\25slime_default_config\ttmux\17slime_target\22slime_no_mappings\6g\24nvim_buf_set_keymap\bapi\bvim\0" },
    keys = { { "", "gr" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-slime",
    url = "https://github.com/jpalardy/vim-slime"
  },
  ["vim-smoothie"] = {
    keys = { { "", "<C-d>" }, { "", "<C-u>" }, { "", "<C-f>" }, { "", "<C-b>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-solarized8"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-solarized8",
    url = "https://github.com/lifepillar/vim-solarized8"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-sxhkdrc"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-sxhkdrc",
    url = "https://github.com/baskerville/vim-sxhkdrc"
  },
  ["vim-systemd-syntax"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax",
    url = "https://github.com/wgwoods/vim-systemd-syntax"
  },
  ["vim-tmux-navigator"] = {
    config = { "\27LJ\2\n�\2\0\0\b\0\15\0#6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1K\0\1\0\"<cmd>TmuxNavigatePrevious<cr>\n<C-\\>\31<cmd>TmuxNavigateRight<cr>\n<C-;>\28<cmd>TmuxNavigateUp<cr>\n<C-k>\30<cmd>TmuxNavigateDown<cr>\n<C-j>\30<cmd>TmuxNavigateLeft<cr>\n<C-h>\6n\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "", "<C-h>" }, { "", "<C-j>" }, { "", "<C-k>" }, { "", "<C-;>" }, { "", "<C-\\>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-tridactyl"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-tridactyl",
    url = "https://github.com/tridactyl/vim-tridactyl"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-unimpaired",
    url = "https://github.com/anihm136/vim-unimpaired"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  vimade = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vimade",
    url = "https://github.com/TaDaa/vimade"
  },
  ["vimproc.vim"] = {
    loaded = true,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/start/vimproc.vim",
    url = "https://github.com/Shougo/vimproc.vim"
  },
  ["wstrip.vim"] = {
    commands = { "WStrip" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/anihm136/.local/share/nvim/site/pack/packer/opt/wstrip.vim",
    url = "https://github.com/tweekmonster/wstrip.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim/"
time([[Runtimepath customization]], false)
-- Setup for: vim-unimpaired
time([[Setup for vim-unimpaired]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\n\0\v6\0\0\0009\0\1\0005\1\3\0005\2\5\0005\3\4\0=\3\6\0025\3\a\0=\3\b\2=\2\t\1=\1\2\0K\0\1\0\rexcludes\tkeys\1\4\0\0\a=P\a[P\a]P\14nextprevs\1\0\0\1\5\0\0\6f\6a\6q\6l\1\0\1\ftoggles\3\0\23unimpaired_mapping\6g\bvim\0", "setup", "vim-unimpaired")
time([[Setup for vim-unimpaired]], false)
time([[packadd for vim-unimpaired]], true)
vim.cmd [[packadd vim-unimpaired]]
time([[packadd for vim-unimpaired]], false)
-- Setup for: kommentary
time([[Setup for kommentary]], true)
try_loadstring("\27LJ\2\nD\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\1\0=\1\2\0K\0\1\0'kommentary_create_default_mappings\6g\bvim\0", "setup", "kommentary")
time([[Setup for kommentary]], false)
-- Setup for: vim-search-pulse
time([[Setup for vim-search-pulse]], true)
try_loadstring("\27LJ\2\n�\4\0\0\b\0\21\0I6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\5\0009\0\6\0005\1\a\0\18\2\0\0'\4\b\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\b\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\b\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\b\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\17\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\17\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\17\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\17\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\b\0'\5\b\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\b\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1K\0\1\0\17N<Plug>Pulse\6N\17n<Plug>Pulse\6x&<Plug>(asterisk-gz#)<Plug>(pulse)\ag#&<Plug>(asterisk-gz*)<Plug>(pulse)\ag*%<Plug>(asterisk-z#)<Plug>(pulse)\6#%<Plug>(asterisk-z*)<Plug>(pulse)\6*\6n\1\0\1\vsilent\2\20nvim_set_keymap\bapi+vim_search_pulse_disable_auto_mappings\fpattern\26vim_search_pulse_mode\6g\bvim\0", "setup", "vim-search-pulse")
time([[Setup for vim-search-pulse]], false)
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
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\31tmux_navigator_no_mappings\6g\bvim\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
-- Setup for: lightspeed.nvim
time([[Setup for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\n�\6\0\0\f\0\24\00064\0\20\0005\1\0\0>\1\1\0005\1\1\0>\1\2\0005\1\2\0>\1\3\0005\1\3\0>\1\4\0005\1\4\0>\1\5\0005\1\5\0>\1\6\0005\1\6\0>\1\a\0005\1\a\0>\1\b\0005\1\b\0>\1\t\0005\1\t\0>\1\n\0005\1\n\0>\1\v\0005\1\v\0>\1\f\0005\1\f\0>\1\r\0005\1\r\0>\1\14\0005\1\14\0>\1\15\0005\1\15\0>\1\16\0005\1\16\0>\1\17\0005\1\17\0>\1\18\0005\1\18\0>\1\19\0006\1\19\0\18\3\0\0B\1\2\4X\4\b�6\6\20\0009\6\21\0069\6\22\6:\b\1\5:\t\2\5:\n\3\0055\v\23\0B\6\5\1E\4\3\3R\4�\127K\0\1\0\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\vipairs\1\4\0\0\6o\6T\23<Plug>Lightspeed_T\1\4\0\0\6o\6t\23<Plug>Lightspeed_t\1\4\0\0\6x\6T\23<Plug>Lightspeed_T\1\4\0\0\6x\6t\23<Plug>Lightspeed_t\1\4\0\0\6n\6T\23<Plug>Lightspeed_T\1\4\0\0\6n\6t\23<Plug>Lightspeed_t\1\4\0\0\6o\6F\23<Plug>Lightspeed_F\1\4\0\0\6o\6f\23<Plug>Lightspeed_f\1\4\0\0\6x\6F\23<Plug>Lightspeed_F\1\4\0\0\6x\6f\23<Plug>Lightspeed_f\1\4\0\0\6n\6F\23<Plug>Lightspeed_F\1\4\0\0\6n\6f\23<Plug>Lightspeed_f\1\4\0\0\6o\6X\23<Plug>Lightspeed_X\1\4\0\0\6o\6x\23<Plug>Lightspeed_x\1\4\0\0\6o\6Z\23<Plug>Lightspeed_S\1\4\0\0\6o\6z\23<Plug>Lightspeed_s\1\4\0\0\6x\6s\23<Plug>Lightspeed_s\1\4\0\0\6n\6S\23<Plug>Lightspeed_S\1\4\0\0\6n\6s\23<Plug>Lightspeed_s\0", "setup", "lightspeed.nvim")
time([[Setup for lightspeed.nvim]], false)
-- Config for: vim-rooter
time([[Config for vim-rooter]], true)
try_loadstring("\27LJ\2\n�\2\0\0\2\0\f\0\0256\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0005\1\v\0=\1\n\0K\0\1\0\1\6\0\0\t.git\rMakefile\17package.json\fPipfile\21requirements.txt\20rooter_patterns\blcd\18rooter_cd_cmd\6*\19rooter_targets\24rooter_silent_chdir\25rooter_resolve_links\fcurrent2rooter_change_directory_for_non_project_files\6g\bvim\0", "config", "vim-rooter")
time([[Config for vim-rooter]], false)
-- Config for: feline.nvim
time([[Config for feline.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfeline\frequire\0", "config", "feline.nvim")
time([[Config for feline.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n*\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\t<cr>\14<cmd>lua �\v\1\0\n\0%\0�\0016\0\0\0009\0\1\0009\0\2\0005\1\3\0003\2\4\0\18\3\0\0'\5\5\0'\6\6\0\18\a\2\0'\t\a\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\b\0\18\a\2\0'\t\a\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\t\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\v\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\f\0\18\a\2\0'\t\r\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\14\0\18\a\2\0'\t\15\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\16\0\18\a\2\0'\t\17\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\18\0\18\a\2\0'\t\19\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\20\0\18\a\2\0'\t\21\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\22\0\18\a\2\0'\t\23\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\24\0\18\a\2\0'\t\23\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\25\0\18\a\2\0'\t\26\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\27\0\18\a\2\0'\t\28\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\29\0\18\a\2\0'\t\30\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6\31\0\18\a\2\0'\t \0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6!\0\18\a\2\0'\t\"\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\5\0'\6#\0\18\a\2\0'\t$\0B\a\2\2\18\b\1\0B\3\5\1K\0\1\0008require('telescope_config').lsp_workspace_symbols()\agW7require('telescope_config').lsp_document_symbols()\ag0+require('telescope_config').commands()\14<leader>:-require('session-lens').search_session()\15<leader>ss,require('telescope_config').help_tags()\15<leader>fh)require('telescope_config').curbuf()\15<leader>sb\15<leader>bb*require('telescope_config').buffers()\14<leader>,.require('telescope_config').grep_prompt()\15<leader>rwBrequire('telescope_config').live_grep(vim.fn.expand(\"%:p:h\"))\15<leader>sd,require('telescope_config').live_grep()\15<leader>sp)require('telescope_config').recent()\15<leader>fr0require('telescope_config').edit_dotfiles()\15<leader>fp\14<leader>.Drequire('telescope_config').file_search(vim.fn.expand(\"%:p:h\"))\15<leader>ff\20<leader><space>.require('telescope_config').file_search()\15<leader>pf\6n\0\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\n�\1\0\0\b\0\b\0\0176\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\a\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1K\0\1\0\6n\22<Plug>(EasyAlign)\aga\6x\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: vim-quickrun
time([[Config for vim-quickrun]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0( runtime after/plugin/quickrun.vim \bcmd\bvim\0", "config", "vim-quickrun")
time([[Config for vim-quickrun]], false)
-- Config for: vim-qf
time([[Config for vim-qf]], true)
try_loadstring("\27LJ\2\n�\4\0\0\b\0\23\0;6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\0016\2\0\0009\2\19\2+\3\2\0=\3\20\0026\2\0\0009\2\19\2+\3\1\0=\3\21\0026\2\0\0009\2\19\2+\3\1\0=\3\22\2K\0\1\0\25qf_auto_open_loclist\26qf_auto_open_quickfix\25qf_mapping_ack_style\6g\25<Plug>(qf_qf_switch)\t<F3>\31<Plug>(qf_loc_toggle_stay)\t<F4>\30<Plug>(qf_qf_toggle_stay)\t<F5>\28<Plug>(qf_loc_previous)\a[l\24<Plug>(qf_loc_next)\a]l\27<Plug>(qf_qf_previous)\a[q\23<Plug>(qf_qf_next)\a]q\6n\1\0\1\vsilent\2\20nvim_set_keymap\bapi\bvim\0", "config", "vim-qf")
time([[Config for vim-qf]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n�\4\0\0\t\0 \0U6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\30\0004\4\15\0009\5\3\0009\5\4\0059\5\5\5>\5\1\0049\5\3\0009\5\4\0059\5\6\0059\5\a\0055\a\t\0005\b\b\0=\b\n\aB\5\2\2>\5\2\0049\5\3\0009\5\v\0059\5\f\5>\5\3\0049\5\3\0009\5\v\0059\5\r\5>\5\4\0049\5\3\0009\5\4\0059\5\14\5>\5\5\0049\5\3\0009\5\4\0059\5\15\0059\5\a\0055\a\17\0005\b\16\0=\b\n\aB\5\2\2>\5\6\0049\5\3\0009\5\4\0059\5\18\5>\5\a\0049\5\3\0009\5\v\0059\5\19\5>\5\b\0049\5\3\0009\5\4\0059\5\19\5>\5\t\0049\5\3\0009\5\v\0059\5\20\5>\5\n\0049\5\3\0009\5\4\0059\5\21\0059\5\a\0055\a\23\0005\b\22\0=\b\24\aB\5\2\2>\5\v\0049\5\3\0009\5\v\0059\5\25\0059\5\a\0055\a\27\0005\b\26\0=\b\24\aB\5\2\2>\5\f\0049\5\3\0009\5\4\0059\5\28\5>\5\r\0049\5\3\0009\5\4\0059\5\29\5>\5\14\4=\4\31\3B\1\2\1K\0\1\0\fsources\1\0\0\vstylua\rfourmolu\1\0\0\1\2\0\0\tbash\15shellcheck\20extra_filetypes\1\0\0\1\2\0\0\tbash\nshfmt\bzsh\reslint_d\14prettierd\1\0\0\1\2\0\0\17--style=file\17clang_format\ngofmt\18golangci_lint\vflake8\16diagnostics\15extra_args\1\0\0\1\3\0\0\14--profile\nblack\twith\nisort\nblack\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n�\4\0\0\6\0\29\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\v\0005\4\6\0005\5\a\0=\5\b\0045\5\t\0=\5\n\4=\4\f\0035\4\r\0005\5\14\0=\5\15\4=\4\16\3=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\0025\3\26\0005\4\27\0=\4\15\3=\3\28\2B\0\2\1K\0\1\0\17textsubjects\1\0\2\6;!textsubjects-container-outer\6.\23textsubjects-smart\1\0\1\venable\2\fmatchup\1\0\1\venable\2\fautotag\1\0\1\venable\2\26context_commentstring\1\0\1\venable\2\vindent\1\0\1\venable\1\16textobjects\vselect\fkeymaps\1\0\4\aaf\20@function.outer\aif\20@function.inner\aac\17@class.outer\aic\17@class.inner\1\0\1\venable\2\tswap\1\0\0\18swap_previous\1\0\1\ag<\21@parameter.inner\14swap_next\1\0\1\ag>\21@parameter.inner\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0", "config", "vim-matchup")
time([[Config for vim-matchup]], false)
-- Config for: vim-llvm
time([[Config for vim-llvm]], true)
try_loadstring("\27LJ\2\n5\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\24llvm_ext_no_mapping\6g\bvim\0", "config", "vim-llvm")
time([[Config for vim-llvm]], false)
-- Config for: neovim-session-manager
time([[Config for neovim-session-manager]], true)
try_loadstring("\27LJ\2\n�\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\18autoload_mode\1\0\0\rDisabled\17AutoloadMode\27session_manager.config\nsetup\20session_manager\frequire\0", "config", "neovim-session-manager")
time([[Config for neovim-session-manager]], false)
-- Config for: harpoon
time([[Config for harpoon]], true)
try_loadstring("\27LJ\2\n�\1\0\0\b\0\t\0\0176\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1K\0\1\0004<cmd>lua require(\"harpoon.mark\").add_file()<cr>\15<leader>pa;<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<cr>\15<leader>ph\6n\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0", "config", "harpoon")
time([[Config for harpoon]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\n*\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\t<cr>\14<cmd>lua �\2\1\0\n\0\14\0+6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\1\6\0003\2\a\0\18\3\0\0'\5\b\0'\6\t\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\b\0'\6\v\0\18\a\2\0'\t\f\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\r\0'\6\t\0\18\a\2\0'\t\n\0B\a\2\2\18\b\1\0B\3\5\1\18\3\0\0'\5\r\0'\6\v\0\18\a\2\0'\t\f\0B\a\2\2\18\b\1\0B\3\5\1K\0\1\0\6x\30require'hop'.hint_lines()\bgsj\30require'hop'.hint_words()\bgsw\6n\0\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: auto-pairs
time([[Config for auto-pairs]], true)
try_loadstring("\27LJ\2\n�\1\0\0\2\0\b\0\0216\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0006\0\0\0009\0\1\0+\1\1\0=\1\a\0K\0\1\0\28AutoPairsCompatibleMaps\28AutoPairsMultilineClose\5*AutoPairsShortcutToggleMultilineClose!AutoPairsCompleteOnlyOnSpace\19AutoPairsMapBS\6g\bvim\0", "config", "auto-pairs")
time([[Config for auto-pairs]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n�\v\0\0\t\0\28\00166\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\2\4\0025\3\6\0=\3\5\0029\2\3\0019\2\a\0024\3\5\0009\4\b\1'\6\t\0'\a\n\0'\b\v\0B\4\4\2>\4\1\0039\4\b\1'\6\f\0'\a\r\0'\b\14\0B\4\4\2>\4\2\0039\4\b\1'\6\15\0'\a\16\0'\b\17\0B\4\4\2>\4\3\0039\4\b\1'\6\18\0'\a\19\0'\b\20\0B\4\4\0?\4\0\0=\3\5\0026\2\0\0'\4\21\0B\2\2\0029\3\3\0019\3\22\3\18\4\2\0B\4\1\2=\4\5\0039\3\23\0009\5\24\1B\3\2\0016\3\25\0009\3\26\3'\5\27\0B\3\2\1K\0\1\0006    autocmd FileType alpha setlocal nofoldenable\n\bcmd\bvim\topts\nsetup\vfooter\18alpha.fortune\f:qa<CR>\21  > Quit NVIM\6q9:lua require(\"telescope_config\").edit_dotfiles()<CR>\20  > Dotfiles\6d\28:Telescope frecency<CR>\19  > Frecent\6r :ene <BAR> startinsert <CR>\20  > New file\6e\vbutton\fbuttons\1\t\0\0:                                                     �\1  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ �\1  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ �\1  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ �\1  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ �\1  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ �\1  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ :                                                     \bval\vheader\fsection\27alpha.themes.dashboard\nalpha\frequire\t����\4\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: vim-sandwich
time([[Config for vim-sandwich]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0000runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0", "config", "vim-sandwich")
time([[Config for vim-sandwich]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\17watch_gitdir\1\0\1\rinterval\3�\15\fkeymaps\1\0\1\20update_debounce\3�\3\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'\texpr\2\1\0\3\fnoremap\2\17n <leader>gl4<cmd>lua require\"gitsigns\".blame_line(true)<cr>\vbuffer\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd vim-asterisk ]]
vim.cmd [[ packadd vim-search-pulse ]]
vim.cmd [[ packadd cmp-nvim-lsp ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Farf lua require("packer.load")({'far.vim'}, { cmd = "Farf", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffConflicts lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflicts", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffConflictsShowHistory lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflictsShowHistory", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffConflictsWithHistory lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflictsWithHistory", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Abolish lua require("packer.load")({'vim-abolish'}, { cmd = "Abolish", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Subvert lua require("packer.load")({'vim-abolish'}, { cmd = "Subvert", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeFindFile lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeFindFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file WStrip lua require("packer.load")({'wstrip.vim'}, { cmd = "WStrip", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Far lua require("packer.load")({'far.vim'}, { cmd = "Far", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Farp lua require("packer.load")({'far.vim'}, { cmd = "Farp", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Farr lua require("packer.load")({'far.vim'}, { cmd = "Farr", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> cr. <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "cr.", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_x <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_x", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gr <cmd>lua require("packer.load")({'vim-slime'}, { keys = "gr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcy <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcy", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>0 <cmd>lua require("packer.load")({'nvim-tree.lua'}, { keys = "<lt>leader>0", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> cru <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "cru", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_t <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-\> <cmd>lua require("packer.load")({'vim-tmux-navigator'}, { keys = "<lt>C-\\>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcyy <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcyy", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> crm <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "crm", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcd <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-j> <cmd>lua require("packer.load")({'vim-tmux-navigator'}, { keys = "<lt>C-j>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> cr  <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "cr ", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> crc <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "crc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_S <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> cr- <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "cr-", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_s <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_T <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_T", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gJ <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gJ", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-f> <cmd>lua require("packer.load")({'vim-smoothie'}, { keys = "<lt>C-f>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-;> <cmd>lua require("packer.load")({'vim-tmux-navigator'}, { keys = "<lt>C-;>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_X <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_X", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> crs <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "crs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-d> <cmd>lua require("packer.load")({'vim-smoothie'}, { keys = "<lt>C-d>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-k> <cmd>lua require("packer.load")({'vim-tmux-navigator'}, { keys = "<lt>C-k>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gS <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_F <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcdd <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcdd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>Lightspeed_f <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "<lt>Plug>Lightspeed_f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-h> <cmd>lua require("packer.load")({'vim-tmux-navigator'}, { keys = "<lt>C-h>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-u> <cmd>lua require("packer.load")({'vim-smoothie'}, { keys = "<lt>C-u>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> crt <cmd>lua require("packer.load")({'vim-abolish'}, { keys = "crt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-b> <cmd>lua require("packer.load")({'vim-smoothie'}, { keys = "<lt>C-b>", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-ts-autotag'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-ts-autotag'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType vue ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "vue" }, _G.packer_plugins)]]
vim.cmd [[au FileType svelte ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "svelte" }, _G.packer_plugins)]]
vim.cmd [[au FileType php ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "php" }, _G.packer_plugins)]]
vim.cmd [[au FileType Dockerfile ++once lua require("packer.load")({'Dockerfile.vim'}, { ft = "Dockerfile" }, _G.packer_plugins)]]
vim.cmd [[au FileType octave ++once lua require("packer.load")({'vim-octave'}, { ft = "octave" }, _G.packer_plugins)]]
vim.cmd [[au FileType systemd ++once lua require("packer.load")({'vim-systemd-syntax'}, { ft = "systemd" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType tmux ++once lua require("packer.load")({'tmux.vim'}, { ft = "tmux" }, _G.packer_plugins)]]
vim.cmd [[au FileType cmake ++once lua require("packer.load")({'vim-cmake-syntax'}, { ft = "cmake" }, _G.packer_plugins)]]
vim.cmd [[au FileType jsonc ++once lua require("packer.load")({'vim-jsonc'}, { ft = "jsonc" }, _G.packer_plugins)]]
vim.cmd [[au FileType csv ++once lua require("packer.load")({'csv.vim'}, { ft = "csv" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'importmagic.nvim', 'vim-slime'}, { ft = "python" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp', 'better-escape.vim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave/ftdetect/octave.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave/ftdetect/octave.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-octave/ftdetect/octave.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim//ftdetect/tmux.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim//ftdetect/tmux.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/tmux.vim/vim//ftdetect/tmux.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax/ftdetect/systemd.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax/ftdetect/systemd.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/vim-systemd-syntax/ftdetect/systemd.vim]], false)
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]], true)
vim.cmd [[source /home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]]
time([[Sourcing ftdetect script at: /home/anihm136/.local/share/nvim/site/pack/packer/opt/csv.vim/ftdetect/csv.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    prompt_prefix = " >",
    winblend = 0,
    preview_cutoff = 120,
    scroll_strategy = "cycle",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5
      }
    },
    sorting_strategy = "descending",
    prompt_position = "bottom",
    color_devicons = true,
    borderchars = {
      {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
    },
    file_sorter = sorters.get_fzy_sorter
  }
}
telescope.load_extension('fzy_native')
telescope.load_extension('frecency')
telescope.load_extension('project')
telescope.load_extension("cheat")

local M = {}

function M.edit_dotfiles()
  require("telescope.builtin").find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config",
    find_command = {"fd", "--hidden", "--follow", "--type", "f"},
    file_ignore_patterns = {"nvim/plugged/.*"},
    search_dirs = {"nvim", "zsh", "antibody", "vifm", "sxhkd"},
    width = .25
  }
end

function M.git_files()
  local opts =
    themes.get_dropdown {
      winblend = 10,
      border = true,
      previewer = false,
      shorten_path = false
    }

  require("telescope.builtin").git_files(opts)
end

function M.live_grep()
  require("telescope.builtin").live_grep {
    shorten_path = true
  }
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    shorten_path = true,
    word_match = "-w",
    search = vim.fn.input("Grep String > ")
  }
end

function M.project_search()
  local rootdir = vim.fn.FindRootDirectory()
  if rootdir == "" then
    rootdir = vim.fn.getcwd()
  end
  require("telescope.builtin").find_files {
    cwd = rootdir
  }
end

function M.buffers()
  local opts =
    themes.get_dropdown {
      layout_strategy = "center",
      winblend = 10,
      border = true,
      previewer = false,
      shorten_path = false
    }
  opts.show_all_buffers = true
  require("telescope.builtin").buffers(opts)
end

function M.curbuf()
  local opts =
    themes.get_dropdown {
      prompt_title = "Buffer lines",
      winblend = 10,
      border = true,
      shorten_path = false
    }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require("telescope.builtin").help_tags {
    show_version = true
  }
end

function M.recent()
  require("telescope").extensions.frecency.frecency()
end

return setmetatable(
  {},
  {
    __index = function(_, k)
      if M[k] then
        return M[k]
      else
        return require("telescope.builtin")[k]
      end
    end
  }
)

-- nvim-colorizer
require "colorizer".setup()

-- treesitter
require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true -- false will disable the whole extension
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["g>"] = "@parameter.inner"
            },
            swap_previous = {
                ["g<"] = "@parameter.inner"
            }
        }
    },
    indent = {
        enable = true
    }
}

-- telescope
vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    "<cmd>lua require('telescope_config').project_search()<CR>",
    {noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope_config').git_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>lua require('telescope_config').edit_dotfiles()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>lua require('telescope_config').recent()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rl", "<cmd>lua require('telescope_config').live_grep()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rw", "<cmd>lua require('telescope_config').grep_prompt()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope_config').buffers()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>bl", "<cmd>lua require('telescope_config').curbuf()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope_config').help_tags()<CR>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<leader>pp",
    "<cmd>lua require('telescope').extensions.project.project()<CR>",
    {noremap = true, silent = true}
)

-- gitsigns
require("gitsigns").setup {
    signs = {
        add = {hl = "DiffAdd", text = "│"},
        change = {hl = "DiffChange", text = "│"},
        delete = {hl = "DiffDelete", text = "_"},
        topdelete = {hl = "DiffDelete", text = "‾"},
        changedelete = {hl = "DiffChange", text = "~"}
    },
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
        ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''}
    },
    watch_index = {
        interval = 2000
    },
    sign_priority = 6,
    status_formatter = nil -- Use default
}

-- express_line
local builtin = require("el.builtin")
local extensions = require("el.extensions")
local sections = require("el.sections")
local subscribe = require("el.subscribe")
local lsp_statusline = require("el.plugins.lsp_status")

local git_icon =
    subscribe.buf_autocmd(
    "el_file_icon",
    "BufRead",
    function(_, bufnr)
        local icon = extensions.file_icon(_, bufnr)
        if icon then
            return icon .. " "
        end

        return ""
    end
)

local git_branch =
    subscribe.buf_autocmd(
    "el_git_branch",
    "BufEnter",
    function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
            return " " .. extensions.git_icon() .. " " .. branch
        end
    end
)

local git_changes =
    subscribe.buf_autocmd(
    "el_git_changes",
    "BufWritePost",
    function(window, buffer)
        return extensions.git_changes(window, buffer)
    end
)

require("el").setup {
    generator = function(_, _)
        return {
            " // ",
            extensions.gen_mode {
                format_string = " %s "
            },
            git_branch,
            " ",
            sections.split,
            git_icon,
            sections.maximum_width(builtin.responsive_file(140, 90), 0.30),
            sections.collapse_builtin {
                " ",
                builtin.modified_flag
            },
            sections.split,
            -- lsp_statusline.current_function,
            git_changes,
            "[",
            builtin.line_with_width(3),
            ":",
            builtin.column_with_width(2),
            "]",
            sections.collapse_builtin {
                "[",
                builtin.readonly_list,
                "]"
            },
            builtin.filetype
        }
    end
}

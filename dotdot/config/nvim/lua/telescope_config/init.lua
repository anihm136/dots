local actions = require('telescope.actions')
local themes = require('telescope.themes')
local telescope = require('telescope')

telescope.setup{
	defaults = {
		prompt_prefix = ' >',
		winblend = 0,
		path_display = { 'absolute' },
		scroll_strategy = 'cycle',
		layout_strategy = 'horizontal',
		layout_config = {
			prompt_position = 'bottom',
			preview_cutoff = 120,
			horizontal = {
				width_padding = 0.1,
				height_padding = 0.1,
				preview_width = 0.6,
			},
			vertical = {
				width_padding = 0.05,
				height_padding = 1,
				preview_height = 0.5,
			},
		},
		sorting_strategy = 'descending',
		color_devicons = true,
		borderchars = {
			{ '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
			preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		},
		mappings = {
			i = {
				['<esc>'] = actions.close,
				['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
			},
		},
	},
	extensions = {
		frecency = {
			show_scores = false,
			show_unindexed = true,
			ignore_patterns = { '*.git/*', '*/tmp/*' },
			workspaces = {
				conf = vim.fn.expand('~') .. '/.config',
				scripts = vim.fn.expand('~') .. '/.local/bin/scripts',
			},
		},
	},
}
telescope.load_extension('fzf')
telescope.load_extension('frecency')

local M = {}
local function get_root()
	local ok, rootdir = pcall(vim.fn.FindRootDirectory)
	if not ok or rootdir == '' then
		rootdir = vim.loop.cwd()
	end
	return rootdir
end

function M.edit_dotfiles()
	local find_command = { 'fd', '--hidden', '--follow', '--type', 'f', '.' }
	local search_dirs =
		{ 'nvim', 'zsh', 'sxhkd', 'nnn', 'rofi', 'kitty', 'beets' }
	for _, v in pairs(search_dirs) do
		table.insert(find_command, v)
	end
	require('telescope.builtin').find_files{
		prompt_title = '~ dotfiles ~',
		cwd = '~/.config',
		find_command = find_command,
	}
end

function M.git_files()
	local opts = themes.get_dropdown{
		winblend = 10,
		border = true,
		previewer = false,
	}

	require('telescope.builtin').git_files(opts)
end

function M.live_grep()
	require('telescope.builtin').live_grep{ cwd = get_root() }
end

function M.grep_prompt()
	require('telescope.builtin').grep_string{
		word_match = '-w',
		search = vim.fn.input('Grep String > '),
	}
end

function M.project_search()
	require('telescope.builtin').find_files{ cwd = get_root() }
end

function M.buffers()
	local opts = themes.get_ivy{
		winblend = 10,
		border = true,
		previewer = false,
	}
	opts.show_all_buffers = true
	opts.sort_lastused = true
	opts.layout_config.height = 0.3
	require('telescope.builtin').buffers(opts)
end

function M.curbuf()
	local opts = themes.get_dropdown{
		prompt_title = 'Buffer lines',
		winblend = 10,
		border = true,
	}
	require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.help_tags()
	require('telescope.builtin').help_tags{ show_version = true }
end

function M.recent()
	require('telescope').extensions.frecency.frecency()
end

return setmetatable(
	{},
	{ __index = function(_, k)
		if M[k] then
			return M[k]
		else
			return require('telescope.builtin')[k]
		end
	end }

)

-- nvim-colorizer
require'colorizer'.setup()

-- treesitter
require'nvim-treesitter.configs'.setup{
	ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = { enable = true }, -- false will disable the whole extension
	textobjects = {
		swap = {
			enable = true,
			swap_next = { ['g>'] = '@parameter.inner' },
			swap_previous = { ['g<'] = '@parameter.inner' },
		},
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				af = '@function.outer',
				['if'] = '@function.inner',
				ac = '@class.outer',
				ic = '@class.inner',
			},
		},
	},
	indent = { enable = false },
	context_commentstring = { enable = true },
}

-- telescope
vim.api.nvim_set_keymap(
	'n',
	'<leader>ff',
	"<cmd>lua require('telescope_config').project_search()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>fg',
	"<cmd>lua require('telescope_config').git_files()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>fd',
	"<cmd>lua require('telescope_config').edit_dotfiles()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>fr',
	"<cmd>lua require('telescope_config').recent()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>rl',
	"<cmd>lua require('telescope_config').live_grep()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>rw',
	"<cmd>lua require('telescope_config').grep_prompt()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>,',
	"<cmd>lua require('telescope_config').buffers()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>sb',
	"<cmd>lua require('telescope_config').curbuf()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>fh',
	"<cmd>lua require('telescope_config').help_tags()<CR>",
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>pp',
	"<cmd>lua require('telescope').extensions.project.project()<CR>",
	{
		noremap = true,
		silent = true,
	}
)
vim.api.nvim_set_keymap(
	'n',
	'g0',
	"<cmd>lua require('telescope_config').lsp_document_symbols()<CR>",
	{
		noremap = true,
		silent = true,
	}
)
vim.api.nvim_set_keymap(
	'n',
	'gW',
	"<cmd>lua require('telescope_config').lsp_workspace_symbols()<CR>",
	{
		noremap = true,
		silent = true,
	}
)

-- gitsigns
require('gitsigns').setup{
	signs = {
		add = {
			hl = 'DiffAdd',
			text = '│',
		},
		change = {
			hl = 'DiffChange',
			text = '│',
		},
		delete = {
			hl = 'DiffDelete',
			text = '_',
		},
		topdelete = {
			hl = 'DiffDelete',
			text = '‾',
		},
		changedelete = {
			hl = 'DiffChange',
			text = '~',
		},
	},
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,
		['n ]c'] = {
			expr = true,
			"&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
		},
		['n [c'] = {
			expr = true,
			"&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
		},
	},
	watch_index = { interval = 2000 },
	sign_priority = 6,
	status_formatter = nil, -- Use default
}

-- lualine
local function min_width()
	return vim.api.nvim_win_get_width(0) > 120
end

require('lualine').setup{
	options = {
		theme = 'gruvbox',
		section_separators = { '', '' },
		component_separators = { '', '' },
		icons_enabled = true,
	},
	sections = {
		lualine_a = { {
			'mode',
			upper = true,
		} },
		lualine_b = { {
			'branch',
			icon = '',
		} },
		lualine_c = { {
			'filename',
			file_status = true,
			full_path = true,
			shorten = true,
			separator = '',
			condition = min_width,
		}, {
			'filename',
			file_status = true,
			separator = '',
			condition = function()
				return not min_width()
			end,
		}, {
			function()
				return '%='
			end,
			separator = '',
		}, {
			function()
				local msg = 'No Active Lsp'
				local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if client.name ~= 'efm' or #clients == 1 then
						if filetypes and vim.fn.index(
							filetypes,
							buf_ft
						) ~= -1 then
							return client.name
						end
					end
				end
				return msg
			end,
			icon = '  LSP:',
		} },
		lualine_x = { {
			'encoding',
			condition = min_width,
		}, {
			'fileformat',
			condition = min_width,
		}, { 'filetype' } },
		lualine_y = { 'diff' },
		lualine_z = { {
			'progress',
			color = 'lualine_z',
		}, {
			'location',
			color = 'lualine_z',
			condition = min_width,
		} },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { 'nvim-tree' },
}

-- Compe
require'compe'.setup{
	enabled = true,
	autocomplete = false,
	debug = false,
	min_length = 1,
	preselect = 'enable',
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	source = {
		path = true,
		buffer = true,
		calc = true,
		vsnip = true,
		nvim_lsp = true,
		nvim_lua = true,
		-- spell = true;
		tags = true,
		snippets_nvim = true,
		treesitter = true,
		vim_dadbod_completion = true,
	},
}

-- Kommentary
local kconfig = require('kommentary.config')
kconfig.configure_language('default', { prefer_single_line_comments = true })
function comment_and_duplicate(...)
	local args = { ... }
	local configuration = config.get_config(0)
	local start_line = args[1]
	local end_line = args[2]
	local content =
		vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	vim.api.nvim_buf_set_lines(0, end_line, end_line, false, content)
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
		'n',
		true
	)
	require('kommentary').toggle_comment_singles(...)
end
function comment_and_yank(...)
	local args = { ... }
	local configuration = config.get_config(0)
	local start_line = args[1]
	local end_line = args[2]
	vim.api.nvim_command(
		tostring(start_line) .. ',' .. tostring(end_line) .. 'y'
	)
	require('kommentary').toggle_comment_singles(...)
end

kconfig.add_keymap(
	'v',
	'kommentary_comment_and_yank_visual',
	kconfig.context.visual,
	{},
	'comment_and_yank'
)
kconfig.add_keymap(
	'n',
	'kommentary_comment_and_yank_motion',
	kconfig.context.init,
	{ expr = true },
	'comment_and_yank'
)
kconfig.add_keymap(
	'n',
	'kommentary_comment_and_yank',
	kconfig.context.line,
	{},
	'comment_and_yank'
)
kconfig.add_keymap(
	'v',
	'kommentary_comment_and_duplicate_visual',
	kconfig.context.visual,
	{},
	'comment_and_duplicate'
)
kconfig.add_keymap(
	'n',
	'kommentary_comment_and_duplicate_motion',
	kconfig.context.init,
	{ expr = true },
	'comment_and_duplicate'
)
kconfig.add_keymap(
	'n',
	'kommentary_comment_and_duplicate',
	kconfig.context.line,
	{},
	'comment_and_duplicate'
)
-- Set up a regular keymapping to the new <Plug> mapping
vim.api.nvim_set_keymap('n', 'gcc', '<Plug>kommentary_line_default', {})
vim.api.nvim_set_keymap('n', 'gc', '<Plug>kommentary_motion_default', {})
vim.api.nvim_set_keymap('v', 'gc', '<Plug>kommentary_visual_default<Esc>', {})
vim.api.nvim_set_keymap(
	'n',
	'gcyy',
	'<Plug>kommentary_comment_and_yank',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'gcy',
	'<Plug>kommentary_comment_and_yank_motion',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	'v',
	'gcy',
	'<Plug>kommentary_comment_and_yank_visual',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'gcdd',
	'<Plug>kommentary_comment_and_duplicate',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'gcd',
	'<Plug>kommentary_comment_and_duplicate_motion',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	'v',
	'gcd',
	'<Plug>kommentary_comment_and_duplicate_visual',
	{ silent = true }
)

-- LspSaga
require 'lspsaga'.init_lsp_saga()

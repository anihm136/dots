local helpers = {}
local api = vim.api

local t = function(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

-- check if window with buffer of given filetype is open
helpers.open_window = function(val, checkvar)
	if checkvar == nil then
		checkvar = "filetype"
	end
	for _, win_id in pairs(api.nvim_list_wins()) do
		local cur_val = vim.bo[api.nvim_win_get_buf(win_id)][checkvar]
		if cur_val == val then
			return win_id
		end
	end
	return -1
end

-- lsp formatting
helpers.format = function()
	vim.cmd[[undojoin]]
	vim.lsp.buf.format(
		vim.tbl_extend("force", {async = true}, vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
	)
end

-- smart tab completion:
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(
		0,
		line - 1,
		line,
		true
	)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes(key, true, true, true),
		mode,
		true
	)
end

--	next completion is pum is open
--	expand or next placeholder snippet from snippy if available
--	start completion if word is present behind
--	insert <tab> otherwise
helpers.smart_tab = function(fallback)
	local snippy = require"snippy"
	local cmp = require"cmp"
	if cmp.visible() then
		cmp.select_next_item()
	elseif snippy.can_expand_or_advance() then
		feedkey('<cmd>lua require("snippy").expand_or_advance()<cr>', "")
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

--	prev completion is pum is open
--	previous snippet placeholder from snippy if available
--	remove <tab> if present
--	do nothing otherwise
helpers.smart_backtab = function(fallback)
	local snippy = require"snippy"
	local cmp = require"cmp"
	if cmp.visible() then
		cmp.select_prev_item()
	elseif snippy.can_jump(-1) then
		feedkey('<cmd>lua require("snippy").previous()<cr>', "")
	elseif api.nvim_get_current_line()[api.nvim_win_get_cursor(0)[2]]:match(
		"[" .. t"<tab>" .. " ]"
	) then
		feedkey("<bs>", "i")
	else
		fallback()
	end
end

helpers.get_random_colorscheme = function(colorscheme_type)
	local function round(num)
		return num + (2 ^ 52 + 2 ^ 51) - (2 ^ 52 + 2 ^ 51)
	end
	local dark_colors =
		{
			"gruvbit",
			"equinusocio_material",
			"solarized8_flat",
			"despacio",
			"dogrun",
			"miramare",
			"tokyonight",
			"nightfox",
		}
	local light_colors =
		{ "solarized8_flat", "tempus_totus", "tempus_day", "tokyonight" }
	math.randomseed(io.popen("od -vAn -N2 -d < /dev/urandom"):read("*a"))
	if colorscheme_type == "dark" then
		local index = (round(math.random() * 10) % #dark_colors) + 1
		return dark_colors[index]
	elseif colorscheme_type == "light" then
		local index = (round(math.random() * 10) % #light_colors) + 1
		return light_colors[index]
	else
		return colorscheme_type
	end
end

helpers.set_sl_colors = function()
	local colors = require("slthemer").getSlColors()
	local hlGroups = {
		lualine_a_normal = { colors.Normal, colors.Background },
		lualine_a_insert = { colors.Insert, colors.Background },
		lualine_a_visual = { colors.Visual, colors.Background },
		lualine_a_replace = { colors.Replace, colors.Background },
		lualine_a_command = { colors.Cmdline, colors.Background },
		lualine_b_normal = { colors.Text, colors.Background2 },
		lualine_b_insert = { colors.Text, colors.Background2 },
		lualine_b_visual = { colors.Text, colors.Background2 },
		lualine_b_replace = { colors.Text, colors.Background2 },
		lualine_b_command = { colors.Text, colors.Background2 },
		lualine_y_diff_added_normal = { nil, colors.Background2 },
		lualine_y_diff_added_insert = { nil, colors.Background2 },
		lualine_y_diff_added_visual = { nil, colors.Background2 },
		lualine_y_diff_added_replace = { nil, colors.Background2 },
		lualine_y_diff_added_command = { nil, colors.Background2 },
		lualine_y_diff_modified_normal = { nil, colors.Background2 },
		lualine_y_diff_modified_insert = { nil, colors.Background2 },
		lualine_y_diff_modified_visual = { nil, colors.Background2 },
		lualine_y_diff_modified_replace = { nil, colors.Background2 },
		lualine_y_diff_modified_command = { nil, colors.Background2 },
		lualine_y_diff_removed_normal = { nil, colors.Background2 },
		lualine_y_diff_removed_insert = { nil, colors.Background2 },
		lualine_y_diff_removed_visual = { nil, colors.Background2 },
		lualine_y_diff_removed_replace = { nil, colors.Background2 },
		lualine_y_diff_removed_command = { nil, colors.Background2 },
		lualine_c_normal = { colors.Text, colors.LineBackground },
		lualine_c_insert = { colors.Text, colors.LineBackground },
		lualine_c_visual = { colors.Text, colors.LineBackground },
		lualine_c_replace = { colors.Text, colors.LineBackground },
		lualine_c_command = { colors.Text, colors.LineBackground },
		lualine_a_inactive = { colors.Text, colors.LineBackground },
		lualine_b_inactive = { colors.Text, colors.LineBackground },
		lualine_c_inactive = { colors.Text, colors.LineBackground },
		lualine_z = { colors.FileStats, colors.Background },
		lualine_a_normal_to_lualine_b_normal = {
			colors.Background,
			colors.Background2,
		},
		lualine_a_insert_to_lualine_b_insert = {
			colors.Background,
			colors.Background2,
		},
		lualine_a_visual_to_lualine_b_visual = {
			colors.Background,
			colors.Background2,
		},
		lualine_a_replace_to_lualine_b_replace = {
			colors.Background,
			colors.Background2,
		},
		lualine_a_command_to_lualine_b_command = {
			colors.Background,
			colors.Background2,
		},
		lualine_b_normal_to_lualine_a_normal = {
			colors.Background,
			colors.Background2,
		},
		lualine_b_insert_to_lualine_a_insert = {
			colors.Background,
			colors.Background2,
		},
		lualine_b_visual_to_lualine_a_visual = {
			colors.Background,
			colors.Background2,
		},
		lualine_b_replace_to_lualine_a_replace = {
			colors.Background,
			colors.Background2,
		},
		lualine_b_command_to_lualine_a_command = {
			colors.Background,
			colors.Background2,
		},
		lualine_a_normal_to_lualine_c_normal = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_a_insert_to_lualine_c_insert = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_a_visual_to_lualine_c_visual = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_a_replace_to_lualine_c_replace = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_a_command_to_lualine_c_command = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_c_normal_to_lualine_z = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_c_insert_to_lualine_z = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_c_visual_to_lualine_z = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_c_replace_to_lualine_z = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_c_command_to_lualine_z = {
			colors.Background,
			colors.LineBackground,
		},
		lualine_y_diff_added_normal_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_added_insert_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_added_visual_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_added_replace_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_added_command_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_removed_normal_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_z_to_lualine_y_diff_removed_insert = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_removed_visual_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_removed_replace_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_removed_command_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_modified_normal_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_modified_insert_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_modified_visual_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_modified_replace_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_y_diff_modified_command_to_lualine_z = {
			colors.Background,
			colors.Background2,
		},
		lualine_b_normal_to_lualine_c_normal = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_b_insert_to_lualine_c_insert = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_b_visual_to_lualine_c_visual = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_b_replace_to_lualine_c_replace = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_b_command_to_lualine_c_command = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_normal_to_lualine_b_normal = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_insert_to_lualine_b_insert = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_visual_to_lualine_b_visual = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_replace_to_lualine_b_replace = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_command_to_lualine_b_command = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_normal_to_lualine_y_diff_added_normal = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_insert_to_lualine_y_diff_added_insert = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_visual_to_lualine_y_diff_added_visual = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_replace_to_lualine_y_diff_added_replace = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_command_to_lualine_y_diff_added_command = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_normal_to_lualine_y_diff_modified_normal = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_insert_to_lualine_y_diff_modified_insert = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_visual_to_lualine_y_diff_modified_visual = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_replace_to_lualine_y_diff_modified_replace = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_command_to_lualine_y_diff_modified_command = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_normal_to_lualine_y_diff_removed_normal = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_insert_to_lualine_y_diff_removed_insert = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_visual_to_lualine_y_diff_removed_visual = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_replace_to_lualine_y_diff_removed_replace = {
			colors.Background2,
			colors.LineBackground,
		},
		lualine_c_command_to_lualine_y_diff_removed_command = {
			colors.Background2,
			colors.LineBackground,
		},
	}
	for k, v in pairs(hlGroups) do
		if v[1] then
			vim.cmd("hi! " .. k .. " guifg=" .. v[1])
		end
		if v[2] then
			vim.cmd("hi! " .. k .. " guibg=" .. v[2])
		end
	end
end

helpers.install_servers = function()
	local servers =
		{
			"clangd",
			"gopls",
			"sumneko_lua",
			"pyright",
			"bashls",
			"cssls",
			"html",
			"jsonls",
			"tsserver",
			"vuels",
			"efm",
		}
	for _, server in pairs(servers) do
		vim.cmd([[LspInstall ]] .. server)
	end
end

return helpers

local helpers = {}
local api = vim.api

local t = function(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

-- check if window with buffer of given filetype is open
helpers.open_window = function(val, checkvar)
	if checkvar == nil then checkvar = 'filetype' end
	for _, win_id in pairs(api.nvim_list_wins()) do
		local cur_val = vim.bo[api.nvim_win_get_buf(win_id)][checkvar]
		if cur_val == val then
			return win_id
		end
	end
	return -1
end

-- toogle popup terminal
helpers.term = function()
	local term_win = helpers.open_window('terminal', 'buftype')
	if term_win ~= -1 then
		api.nvim_buf_delete(
			api.nvim_win_get_buf(term_win),
			{ force = true }
		)
	else
		vim.cmd[[ below 10sp term://$SHELL ]]
	end
end

-- lsp formatting
helpers.formatting = function()
	vim.cmd[[undojoin]]
	vim.lsp.buf.formatting(
		vim.g[string.format('format_options_%s', vim.bo.filetype)] or {}
	)
	vim.defer_fn(function()
		vim.cmd[[DetectIndent]]
	end, 5000)
end

-- smart tab completion:
--	next completion is pum is open
--	expand or next placeholder snippet from snippets.nvim if available
--	expand or next placeholder snippet from vsnip if available
--	insert <tab> otherwise
helpers.tab_complete = function()
	local snippets = require'snippets'
	local _, expanded = snippets.lookup_snippet_at_cursor()
	if vim.fn.pumvisible() == 1 then
		return t'<c-n>'
	elseif snippets.has_active_snippet() or expanded ~= nil then
		return t'<cmd>lua require("snippets").expand_or_advance(1)<cr><cmd>lua helpers.snippet_callback()<cr>'
	elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
		return t'<plug>(vsnip-expand-or-jump)'
	else
		return t'<tab>'
	end
end

-- smart backtab completion:
--	prev completion is pum is open
--	previous snippet placeholder from snippets.nvim if available
--	previous snippet placeholder from vsnip if available
--	remove <tab> if present
--	do nothing otherwise
helpers.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t'<c-p>'
	elseif require('snippets').has_active_snippet() then
		return t'<cmd>lua require("snippets").advance_snippet(-1)<cr><cmd>lua helpers.snippet_callback()<cr>'
	elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
		return t'<plug>(vsnip-jump-prev)'
	elseif api.nvim_get_current_line()[api.nvim_win_get_cursor(
		0
	)[2]]:match('[' .. t'<tab>' .. ' ]') then
		return t'<bs>'
	else
		return t''
	end
end

-- helpers to enable ${visual} for snippets.nvim
helpers.snippet_callback = function()
	if not require('snippets').has_active_snippet() then
		helpers.saved_visual = ''
	end
end

helpers.x_tab = function()
	local selection = helpers.get_visual_selection()
	if selection ~= '' then
		helpers.saved_visual = helpers.get_visual_selection()
		api.nvim_input('c')
	end
end

helpers.insert_saved_visual = function()
	return helpers.saved_visual
end

-- experimenting with get_visual_selection
helpers.get_marked_region = function(mark1, mark2, options)
	print('start region')
	local bufnr = 0
	local adjust = options.adjust or function(pos1, pos2)
		return pos1, pos2
	end
	local regtype = options.regtype or vim.fn.visualmode()
	local selection = options.selection or (vim.o.selection ~= 'exclusive')

	local pos1 = vim.fn.getpos(mark1)
	local pos2 = vim.fn.getpos(mark2)
	pos1, pos2 = adjust(pos1, pos2)

	local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
	local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

	-- Return if start or finish are invalid
	if start[2] < 0 or finish[1] < start[1] then return end

	local region = vim.region(bufnr, start, finish, regtype, selection)
	print('End region')
	return region, start, finish
end

helpers.get_visual_selection = function()
	print('Start selection')
	local visual_modes = {
		v = false,
		V = true,
		-- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
	}

	-- Return if not in visual mode
	if visual_modes[api.nvim_get_mode().mode] == nil or not visual_modes[api.nvim_get_mode().mode] then
		return ''
	end

	local options = {}
	options.adjust = function(pos1, pos2)
		if vim.fn.visualmode() == 'V' then
			pos1[3] = 1
			pos2[3] = 2 ^ 31 - 1
		end

		if pos1[2] > pos2[2] then
			pos2[3], pos1[3] = pos1[3], pos2[3]
			return pos2, pos1
		elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
			-- pos2[3], pos1[3] = pos1[3], pos2[3]
			return pos2, pos1
		else
			return pos1, pos2
		end
	end

	local region, start, finish = helpers.get_marked_region('v', '.', options)

	-- Compute the number of chars to get from the first line,
	-- because vim.region returns -1 as the ending col if the
	-- end of the line is included in the selection
	local lines = api.nvim_buf_get_lines(0, start[1], finish[1] + 1, false)
	local line1_end
	if region[start[1]][2] - region[start[1]][1] < 0 then
		line1_end = #lines[1] - region[start[1]][1]
	else
		line1_end = region[start[1]][2] - region[start[1]][1]
	end

	lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
	if start[1] ~= finish[1] then
		lines[#lines] =
			vim.fn.strpart(
				lines[#lines],
				region[finish[1]][1],
				region[finish[1]][2] - region[finish[1]][1]
			)
	end
	print('End selection')
	return table.concat(lines, '\n')
end

helpers.set_sl_colors = function()
	local colors = require('slthemer').getSlColors()
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
			vim.cmd('hi! ' .. k .. ' guifg=' .. v[1])
		end
		if v[2] then
			vim.cmd('hi! ' .. k .. ' guibg=' .. v[2])
		end
	end
end

return helpers

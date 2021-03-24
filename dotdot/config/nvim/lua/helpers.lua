helpers = {}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Toogle popup terminal
helpers.term = function()
	local term_win = -1
	for _, val in pairs(vim.api.nvim_list_wins()) do
		local status, _ =
			pcall(
				vim.api.nvim_buf_get_var,
				vim.api.nvim_win_get_buf(val),
				'term_title'
			)
		if status then
			term_win = val
			break
		end
	end
	if term_win ~= -1 then
		vim.api.nvim_buf_delete(
			vim.api.nvim_win_get_buf(term_win),
			{ force = true }
		)
	else
		vim.cmd[[ below 10sp term://$SHELL ]]
	end
end

-- LSP formatting
helpers.formatting = function()
	vim.cmd[[undojoin]]
	vim.lsp.buf.formatting(
		vim.g[string.format('format_options_%s', vim.bo.filetype)] or {}
	)
	print'Formatted buffer'
	vim.cmd[[DetectIndent]]
end

-- Smart tab completion:
--	Next completion is pum is open
--	Expand or next placeholder snippet from snippets.nvim if available
--	Expand or next placeholder snippet from vsnip if available
--	Insert <TAB> otherwise
helpers.tab_complete = function()
	local snippets = require'snippets'
	local _, expanded = snippets.lookup_snippet_at_cursor()
	if vim.fn.pumvisible() == 1 then
		return t'<C-n>'
	elseif snippets.has_active_snippet() or expanded ~= nil then
		return t'<cmd>lua require("snippets").expand_or_advance(1)<cr><cmd>lua helpers.snippet_callback()<cr>'
	elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
		return t'<Plug>(vsnip-expand-or-jump)'
	else
		return t'<Tab>'
	end
end

-- Smart backtab completion:
--	Prev completion is pum is open
--	Previous snippet placeholder from snippets.nvim if available
--	Previous snippet placeholder from vsnip if available
--	Remove <TAB> if present
--	Do nothing otherwise
helpers.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t'<C-p>'
	elseif require('snippets').has_active_snippet() then
		return t'<cmd>lua require("snippets").advance_snippet(-1)<cr><cmd>lua helpers.snippet_callback()<cr>'
	elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
		return t'<Plug>(vsnip-jump-prev)'
	elseif vim.api.nvim_get_current_line()[vim.api.nvim_win_get_cursor(
		0
	)[2]]:match("["..t"<Tab>".." ]") then
		return t'<BS>'
	else
		return t''
	end
end

-- Helpers to enable ${VISUAL} for snippets.nvim
helpers.snippet_callback = function()
	if not require('snippets').has_active_snippet() then
		helpers.saved_visual = ''
	end
end

helpers.x_tab = function()
	helpers.saved_visual = helpers.get_visual_selection()
	vim.api.nvim_input('c')
end

helpers.insert_saved_visual = function()
	return helpers.saved_visual
end

-- Experimenting with get_visual_selection
helpers.get_marked_region = function(mark1, mark2, options)
	local bufnr = 0
	P(options.adjust)
	local adjust = options.adjust or function(pos1, pos2)
		return pos1, pos2
	end
	local regtype = options.regtype or vim.fn.visualmode()
	local selection = options.selection or (vim.o.selection ~= 'exclusive')

	local pos1 = vim.fn.getpos(mark1)
	local pos2 = vim.fn.getpos(mark2)
	P(pos1)
	P(pos2)
	pos1, pos2 = adjust(pos1, pos2)
	P(pos1)
	P(pos2)

	local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
	local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }
	P(start)
	P(finish)

	-- Return if start or finish are invalid
	if start[2] < 0 or finish[1] < start[1] then return end

	local region = vim.region(bufnr, start, finish, regtype, selection)
	return region, start, finish
end

helpers.get_visual_selection = function()
	local visual_modes = {
		v = true,
		V = true,
		-- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
	}

	-- Return if not in visual mode
	if visual_modes[vim.api.nvim_get_mode().mode] == nil then
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
	local lines =
		vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
	P(region)
	P(lines)
	local line1_end
	if region[start[1]][2] - region[start[1]][1] < 0 then
		line1_end = #lines[1] - region[start[1]][1]
	else
		line1_end = region[start[1]][2] - region[start[1]][1]
	end

	lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
	P(lines)
	if start[1] ~= finish[1] then
		lines[#lines] =
			vim.fn.strpart(
				lines[#lines],
				region[finish[1]][1],
				region[finish[1]][2] - region[finish[1]][1]
			)
		P(lines)
	end
	return table.concat(lines, '\n')
end

helpers.set_sl_colors = function()
	local colors = require('slthemer').getSlColors()
	hlGroups = {
		ElCommand = {colors.Cmdline, colors.Background},
		ElCommandCV = {colors.Cmdline, colors.Background},
		ElCommandEx = {colors.Cmdline, colors.Background},
		ElConfirm = {colors.Cmdline, colors.Background},
		ElInsertCompletion = {colors.Insert, colors.Background},
		ElInsert = {colors.Insert, colors.Background},
		ElMore = {colors.Insert, colors.Background},
		ElNormal = {colors.Normal, colors.Background},
		ElNormalOperatorPending = {colors.Normal, colors.Background},
		ElPrompt = {colors.Cmdline, colors.Background},
		ElReplace = {colors.Replace, colors.Background},
		ElSBlock = {colors.Visual, colors.Background},
		ElSelect = {colors.Visual, colors.Background},
		ElShell = {colors.Cmdline, colors.Background},
		ElSLine = {colors.Visual, colors.Background},
		ElTerm = {colors.Cmdline, colors.Background},
		ElVirtualReplace = {colors.Replace, colors.Background},
		ElVisualBlock = {colors.Visual, colors.Background},
		ElVisualLine = {colors.Visual, colors.Background},
		ElVisual = {colors.Visual, colors.Background},
	}
	for k, v in pairs(hlGroups) do
		if v[1] then
			vim.cmd('hi! '..k..' guifg='..v[1])
		end
		if v[2] then
			vim.cmd('hi! '..k..' guibg='..v[2])
		end
	end
end

return helpers

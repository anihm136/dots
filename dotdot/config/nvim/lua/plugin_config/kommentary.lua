return function()
	local kconfig = require('kommentary.config')
	kconfig.configure_language('default', { prefer_single_line_comments = true })
	function _G.comment_and_duplicate(...)
		local args = { ... }
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
	function _G.comment_and_yank(...)
		local args = { ... }
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
	comment_and_yank
	)
	kconfig.add_keymap(
	'n',
	'kommentary_comment_and_yank_motion',
	kconfig.context.motion,
	{ expr = true },
	comment_and_yank
	)
	kconfig.add_keymap(
	'n',
	'kommentary_comment_and_yank',
	kconfig.context.line,
	{ expr = true },
	comment_and_yank
	)
	kconfig.add_keymap(
	'v',
	'kommentary_comment_and_duplicate_visual',
	kconfig.context.visual,
	{},
	comment_and_duplicate
	)
	kconfig.add_keymap(
	'n',
	'kommentary_comment_and_duplicate_motion',
	kconfig.context.motion,
	{ expr = true },
	comment_and_duplicate
	)
	kconfig.add_keymap(
	'n',
	'kommentary_comment_and_duplicate',
	kconfig.context.line,
	{ expr = true },
	comment_and_duplicate
	)
end

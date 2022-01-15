return function()
	local kconfig = require("kommentary.config")
	kconfig.configure_language("default", {
		prefer_single_line_comments = true,
		hook_function = function()
			require("ts_context_commentstring.internal").update_commentstring()
		end,
	})
	local function comment_and_duplicate(...)
		local args = { ... }
		local start_line = args[1]
		local end_line = args[2]
		local content =
			vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
		vim.api.nvim_buf_set_lines(0, end_line, end_line, false, content)
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
			"n",
			true
		)
		require("kommentary").toggle_comment(...)
	end
	local function comment_and_yank(...)
		local args = { ... }
		local start_line = args[1]
		local end_line = args[2]
		vim.api.nvim_command(
			tostring(start_line) .. "," .. tostring(end_line) .. "y"
		)
		require("kommentary").toggle_comment(...)
	end

	kconfig.add_keymap(
		"v",
		"kommentary_comment_and_yank_visual",
		kconfig.context.visual,
		{},
		comment_and_yank
	)
	kconfig.add_keymap(
		"n",
		"kommentary_comment_and_yank_motion",
		kconfig.context.motion,
		{ expr = true },
		comment_and_yank
	)
	kconfig.add_keymap(
		"n",
		"kommentary_comment_and_yank",
		kconfig.context.line,
		{ expr = true },
		comment_and_yank
	)
	kconfig.add_keymap(
		"v",
		"kommentary_comment_and_duplicate_visual",
		kconfig.context.visual,
		{},
		comment_and_duplicate
	)
	kconfig.add_keymap(
		"n",
		"kommentary_comment_and_duplicate_motion",
		kconfig.context.motion,
		{ expr = true },
		comment_and_duplicate
	)
	kconfig.add_keymap(
		"n",
		"kommentary_comment_and_duplicate",
		kconfig.context.line,
		{ expr = true },
		comment_and_duplicate
	)

	local map = vim.api.nvim_set_keymap
	local opts = { silent = true }

	map("n", "gcc", "<Plug>kommentary_line_default", opts)

	map("n", "gc", "<Plug>kommentary_motion_default", opts)

	map("v", "gc", "<Plug>kommentary_visual_default<Esc>", opts)

	map("n", "gcyy", "<Plug>kommentary_comment_and_yank", opts)

	map("n", "gcy", "<Plug>kommentary_comment_and_yank_motion", opts)

	map("v", "gcy", "<Plug>kommentary_comment_and_yank_visual", opts)

	map("n", "gcdd", "<Plug>kommentary_comment_and_duplicate", opts)

	map("n", "gcd", "<Plug>kommentary_comment_and_duplicate_motion", opts)

	map("v", "gcd", "<Plug>kommentary_comment_and_duplicate_visual", opts)

end

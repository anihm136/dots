-- helpers

helpers = {}

helpers.term = function()
	local term_win = -1
	for _, val in pairs(vim.api.nvim_list_wins()) do
		local status, _ =
			pcall(
				vim.api.nvim_buf_get_var,
				vim.api.nvim_win_get_buf(val),
				"term_title"
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

return helpers
return function()
	local function min_width()
		return vim.api.nvim_win_get_width(0) > 120
	end

	require('lualine').setup{
		options = {
			theme = 'auto',
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
				path = 1,
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
		extensions = { 'nvim-tree', 'quickfix' },
	}
end

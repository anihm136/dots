return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				winblend = 0,
				path_display = { "absolute" },
				scroll_strategy = "cycle",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "bottom",
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
				sorting_strategy = "descending",
				color_devicons = true,
				borderchars = {
					{ "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
				mappings = {
					i = {
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
		})
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")

		local function get_root()
			local ok, rootdir = pcall(vim.fn.FindRootDirectory)
			if not ok or rootdir == "" then
				rootdir = vim.loop.cwd()
			end
			return rootdir
		end

		local function edit_dotfiles()
			local find_command = { "fd", "--hidden", "--follow", "--type", "f", "." }
			local search_dirs = {
				vim.fn.stdpath("config_dirs"),
				{ vim.fn.stdpath("config") },
				{ vim.fn.stdpath("data") },
			}
			for _, dirs in pairs(search_dirs) do
				for _, v in pairs(dirs) do
					table.insert(find_command, v)
				end
			end
			require("telescope.builtin").find_files({
				prompt_title = "~ dotfiles ~",
				cwd = "~/.config/nvim",
				find_command = find_command,
			})
		end

		local function live_grep(cwd)
			cwd = cwd or get_root()
			require("telescope.builtin").live_grep({ cwd = cwd })
		end

		local function file_search(cwd)
			cwd = cwd or get_root()
			require("telescope.builtin").find_files({ cwd = cwd })
		end

		local function buffers()
			local opts = {}
			opts.show_all_buffers = true
			opts.sort_lastused = true
			require("telescope.builtin").buffers(opts)
		end

		local function help_tags()
			require("telescope.builtin").help_tags({ show_version = true })
		end

		local function map(mode, lhs, rhs, desc)
			local opts = {
				noremap = true,
				silent = true,
				unique = true,
			}
			if desc ~= nil then
				opts.desc = desc
			end
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		map("n", "<leader><space>", file_search, "Files in project")
		map("n", "<leader>ff", function()
			file_search(vim.fn.expand("%:p:h"))
		end, "Files in current file's directory")
		map("n", "<leader>fp", edit_dotfiles, "Dotfiles")
		map("n", "<leader>fr", builtin.oldfiles, "Recent files")
		map("n", "<leader>sp", live_grep, "Live grep in project")
		map("n", "<leader>sd", function()
			live_grep(vim.fn.expand("%:p:h"))
		end, "Live grep in current file's directory")
		map("n", "<leader>,", buffers, "Open buffers")
		map("n", "<leader>fh", help_tags, "Vim help tags")
	end,
}

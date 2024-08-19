-- File/item picker. Search for files, and grep through directory

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { ".git", "node_modules", ".cache" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
						layout_config = {
							height = 0.70,
						},
					},
					buffers = {
						show_all_buffers = true,
					},
					live_grep = {
						previewer = false,
						theme = "dropdown",
					},
					git_status = {
						git_icons = {
							added = " ",
							changed = " ",
							copied = " ",
							deleted = " ",
							renamed = "➡",
							unmerged = " ",
							untracked = " ",
						},
						previewer = false,
						theme = "dropdown",
					},
					colorscheme = {
						enable_preview = true,
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}

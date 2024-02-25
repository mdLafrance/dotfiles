-- Syntax highlighting

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				sync_install = false,
				highlight = { enable = true, use_languagetree = true },
				-- indent = { enable = true },
				autotag = {
					enable = true,
				},
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"xml",
					"eruby",
					"embedded_template",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			})
		end,
		lazy = true,
		event = "VeryLazy",
	},
}

-- Adds ui messages and popups

return {
	"folke/noice.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	opts = {
		presets = {
			lsp_doc_border = true,
		},
	},
}

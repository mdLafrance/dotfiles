-- Adds functionality to auto comment/uncomment lines

return {
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
}

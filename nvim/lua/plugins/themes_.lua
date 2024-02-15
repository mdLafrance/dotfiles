-- Main download module for themes

return {
    { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "rose-pine/neovim",         name = "rose-pine" },
    { "Mofiqul/dracula.nvim",     name = "dracula" },
    { "hardhackerlabs/theme-vim", name = "hardhacker" },
    -- {
    --     "ramojus/mellifluous.nvim", name = "mellifluous"
    -- },
    {
        "ramojus/mellifluous.nvim",
        name = "mellifluous",
        setup = function()
            require("mellifluous").setup({
                color_set = "tender"
            })
        end
    },
    { "EdenEast/nightfox.nvim" },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({
                -- Recommended - see "Configuring" below for more config options
                transparent = true,
                italic_comments = true,
                hide_fillchars = true,
                borderless_telescope = true,
            })
        end,
    }
}

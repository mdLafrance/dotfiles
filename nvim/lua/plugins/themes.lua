-- Themes

local old = {
    { "Mofiqul/dracula.nvim",  name = "dracula" },
    {
        "ramojus/mellifluous.nvim",
        name = "mellifluous",
        setup = function()
            require("mellifluous").setup({
                color_set = "tender",
            })
        end,
    },
    { "EdenEast/nightfox.nvim" },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        priority = 1000,
    },
    { "projekt0n/github-nvim-theme" },

    {
        "ramojus/mellifluous.nvim",
        name = "mellifluous",
    },
    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup({
                -- optional configuration here
            })
        end,
    },
    {
        'olivercederborg/poimandres.nvim',
        lazy = false,
        priority = 1000,
    },

}

return {
    { "catppuccin/nvim",  name = "catppuccin", priority = 1000 },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "rose-pine/neovim", name = "rose-pine" },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard"
            })
        end
    },
    {
        "oxfist/night-owl.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            require("night-owl").setup()
            vim.cmd.colorscheme("night-owl")
        end,
    },
    { "hardhackerlabs/theme-vim", name = "hardhacker" },
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
    }
}

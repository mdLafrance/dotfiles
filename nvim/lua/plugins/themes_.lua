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
}

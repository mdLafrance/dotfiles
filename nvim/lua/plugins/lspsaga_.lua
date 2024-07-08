-- Additional LSP support

return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require("lspsaga").setup({
            -- This is the breadcrumbs at the top of the buf
            symbol_in_winbar = {
                enable = true
            }
        })
    end,
}

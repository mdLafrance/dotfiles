-- Botton bar with information about file, line number, etc.

return  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            theme = "dracula"
        })
    end
}

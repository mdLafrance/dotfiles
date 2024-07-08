-- Botton bar with information about file, line number, etc.

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            theme = "horizon",
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'filetype' },
                -- lualine_y = { 'progress' },
                lualine_y = { "require'lsp-status'.status()" },
                lualine_z = { 'location' }
            },
        })
    end
}

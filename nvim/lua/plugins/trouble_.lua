-- Opens a window that shows all code hints, warnings, and errors

return {
    "folke/trouble.nvim",
    tag = "v2.10.0",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        require("trouble").setup()
    end
}

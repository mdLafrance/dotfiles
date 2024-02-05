-- File explorer tree

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    }
    ,
    config = function()
        require("nvim-tree").setup({
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = false,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },
        })
    end
}

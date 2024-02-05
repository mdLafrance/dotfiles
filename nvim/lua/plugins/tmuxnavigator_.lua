-- Integrates nvim with tmux 

return {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        config = function()
            -- vim.keymap.set("n", "<leader>Up", ":TmuxNavigateUp<Cr>", {})
            -- vim.keymap.set("n", "<leader>Down", ":TmuxNavigateDown<Cr>", {})
            -- vim.keymap.set("n", "<leader>Left", ":TmuxNavigateLeft<Cr>", {})
            -- vim.keymap.set("n", "<leader>Right", ":TmuxNavigateRight<Cr>", {})
        end,
    },
}

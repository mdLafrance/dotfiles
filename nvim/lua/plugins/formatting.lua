return {
    {
        "stevearc/conform.nvim",
        opts = {},
        setup = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    javascript = { { "prettierd", "prettier" } },
                    cc = { "astyle" },
                    ["_"] = { "trim_whitespace" },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = false,
                },
            })

            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     pattern = "*",
            --     callback = function(args)
            --         require("conform").format({ bufnr = args.buf })
            --     end,
            -- })
        end,
    },
}

-- Plugins related to editor config

return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                sync_install = false,
                highlight = { enable = true, use_languagetree = true },
                -- indent = { enable = true },
                autotag = {
                    -- enable = true,
                },
            })
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-ts-autotag").setup({
                filetypes = {
                    "html",
                    "xml",
                    "eruby",
                    "embedded_template",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
            })
        end,
        lazy = true,
        event = "VeryLazy",
    },

    -- Config for snippets engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            "windwp/nvim-ts-autotag",
            "windwp/nvim-autopairs",
        },
        config = function()
            local lspkind = require("lspkind")
            local cmp = require("cmp")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "supermaven" },
                    { name = "buffer",    max_item_count = 3 },
                    { name = "path",      max_item_count = 3 }, -- file system paths
                    { name = "luasnip" },
                }),
                -- Enables pictograms in lsp autocomplete suggestions
                formatting = {
                    expandable_indicator = true,
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        max_width = 50,
                        symbol_map = { Supermaven = " " }
                    })
                },
                experimental = {
                    ghost_text = true,
                }
            })

            -- NOTE: Stolen from github - might make lsp markdown render properly
            -- vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
            --     contents = vim.lsp.util._normalize_markdown(contents, {
            --         width = vim.lsp.util._make_floating_popup_size(contents, opts),
            --     })
            --     vim.bo[bufnr].filetype = "markdown"
            --     vim.treesitter.start(bufnr)
            --     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

            --     return contents
            -- end
        end,
    },

    -- Code formatting
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

    -- Additional formatting
    {
        "nvimtools/none-ls.nvim",

        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.cmake_format,
                    null_ls.builtins.formatting.fixjson,
                    null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.eslint_d, -- Javscript
                },
            })
        end,
    },

    -- Auto bracket closing
    {
        'm4xshen/autoclose.nvim',
        config = function()
            require("autoclose").setup()
        end
    }

}

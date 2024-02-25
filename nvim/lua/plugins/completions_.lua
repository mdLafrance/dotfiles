-- Setup for code completion using nvim-cmp

return {
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
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer",  max_item_count = 5 },
                    { name = "path",    max_item_count = 5 }, -- file system paths
                    { name = "luasnip" },
                }),
                -- Enables pictograms in lsp autocomplete suggestions
                formatting = {
                    expandable_indicator = true,
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    })
                },
                experimental = {
                    ghost_text = true,
                }
            })

            -- NOTE: Stolen from github - might make lsp markdown render properly
            vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
                contents = vim.lsp.util._normalize_markdown(contents, {
                    width = vim.lsp.util._make_floating_popup_size(contents, opts),
                })
                vim.bo[bufnr].filetype = "markdown"
                vim.treesitter.start(bufnr)
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

                return contents
            end
        end,
    },
}

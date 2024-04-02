-- Mason lsp server config

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd", --c, c++
                    "cmake",
                    "cssls",
                    "bashls",
                    "dockerls",
                    "docker_compose_language_service",
                    "gopls",
                    "jdtls",                -- java
                    "marksman",             -- markdown
                    "powershell_es",
                    "pyright",              -- python
                    "jedi_language_server", -- python
                    "rust_analyzer",
                    "tsserver",
                    "tailwindcss",
                    "hydra_lsp", -- yaml
                    "eslint",    -- Javascript formatting
                    "jsonls",
                    "taplo",     -- toml
                    "asm_lsp",   -- assembly (nasm)
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                ["rust_analyzer"] = {
                    cargo = {
                        allFeatures = true,
                    },
                },
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.hydra_lsp.setup({
                capabilities = capabilities,
            })

            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })
            lspconfig.taplo.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.dockerls.setup({
                capabilities = capabilities,
            })
            lspconfig.docker_compose_language_service.setup({
                capabilities = capabilities,
            })
            -- lspconfig.jedi_language_server.setup({
            --     capabilities = capabilities,
            -- })
            lspconfig.asm_lsp.setup({
                capabilities = capabilities,
                command = "asdf"
            })

            vim.keymap.set("n", "<leader>1", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>2", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>3", vim.lsp.buf.code_action, {})
        end,
    },
}

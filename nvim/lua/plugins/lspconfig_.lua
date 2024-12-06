-- Mason lsp server config

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                PATH = "append",
            })
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
                    -- "autotools_ls",
                    "cssls",
                    "css_variables",
                    "bashls",
                    "dockerls",
                    "docker_compose_language_service",
                    "gopls",
                    "jdtls", -- java
                    "marksman", -- markdown
                    "powershell_es",
                    "pyright", -- python
                    "jedi_language_server", -- python
                    "rust_analyzer",
                    "ts_ls",
                    "tailwindcss",
                    "hydra_lsp", -- yaml
                    "eslint", -- Javascript formatting
                    "jsonls",
                    "taplo", -- toml
                    "terraformls",
                    "tflint",
                    "templ", -- golang templ files
                    "html",
                    "sqlls",
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
                filetypes = { "css", "scss", "less", "typescript", "typescriptreact", "typescript.tsx" },
            })
            lspconfig.css_variables.setup({
                capabilities = capabilities,
                filetypes = { "css", "scss", "less", "typescript", "typescriptreact", "typescript.tsx" },
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                },
            })
            lspconfig.cmake.setup({
                capabilities = capabilities,
            })
            -- lspconfig.autotools_ls.setup({
            --     capabilities = capabilities,
            -- })
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

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@styled/typescript-styled-plugin",
                            location = "node_modules/@styled/typescript-styled-plugin",
                        },
                    },
                },
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
            lspconfig.terraformls.setup({
                capabilities = capabilities,
            })
            lspconfig.tflint.setup({
                capabilities = capabilities,
            })
            lspconfig.templ.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.sqlls.setup({
                capabilities = capabilities,
                root_dir = function(fname)
                    return require("lspconfig.util").find_git_ancestor(fname) or vim.fn.getcwd()
                end,
            })

            vim.keymap.set("n", "<leader>1", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>2", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>3", vim.lsp.buf.code_action, {})
        end,
    },
}

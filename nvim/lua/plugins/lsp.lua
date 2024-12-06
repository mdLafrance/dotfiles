-- Mason lsp server config

return {
    -- Additional lsp functionality
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require("lspsaga").setup({
                -- This is the breadcrumbs at the top of the buf
                symbol_in_winbar = {
                    enable = true
                }
            })
        end,
    },

    -- LSP integration
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                PATH = "append",
            })
        end,
    },

    -- Automatic download and configuration of LSPs
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
                    "jdtls",                -- java
                    "marksman",             -- markdown
                    "powershell_es",
                    "pyright",              -- python
                    "jedi_language_server", -- python
                    "rust_analyzer",
                    "ts_ls",
                    "tailwindcss",
                    "hydra_lsp", -- yaml
                    "eslint",    -- Javascript formatting
                    "jsonls",
                    "taplo",     -- toml
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
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                },
            })
            lspconfig.cmake.setup({
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

    -- Additional rust tooling
    {
        -- Rust autoformatting on save
        {
            "rust-lang/rust.vim",
            ft = "rust",
            init = function()
                vim.g.rustfmt_autosave = 1
            end,
        },
    },

    -- Supermaven
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({})
        end,
    },

    -- Additional golang tooling
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})

            -- Autoformat go on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimport()
                end,
                group = format_sync_grp,
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    }
}
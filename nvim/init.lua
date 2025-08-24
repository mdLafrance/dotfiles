--------------------- VIM OPTIONS ---------------------
vim.loader.enable()
vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.mouse = 'a'

vim.g.lsp_enabled = true

vim.g.semantic_tokens_enabled = true

-- Suppress all deprecation warnings
vim.deprecate = function() end

-- Setup some diagnostic gui
vim.diagnostic.config({
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    -- virtual_text = true
})

vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",                -- Icons for pretty much everything
    'https://github.com/nvim-telescope/telescope.nvim',              -- The picker
    'https://github.com/nvim-treesitter/nvim-treesitter',            -- Auto highlighting
    "https://github.com/nvim-lualine/lualine.nvim",                  -- The bottom line
    'https://github.com/williamboman/mason.nvim',                    -- LSP install manager
    'https://github.com/nvim-tree/nvim-tree.lua',                    -- File explorer
    "https://github.com/nvim-lua/plenary.nvim",                      -- Lua extensions for multiprocessing
    "https://github.com/nvim-telescope/telescope-file-browser.nvim", -- Telescope extension for file browser
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",    -- Telescope extension to use telescope for builtin-pickers
    'https://github.com/kdheepak/lazygit.nvim',                      -- In-nvim git client
    'https://github.com/hedyhli/outline.nvim',                       -- Right side outliner
    'https://github.com/folke/which-key.nvim',                       -- Hints for keybinds
    'https://github.com/folke/trouble.nvim',                         -- Bottom-drawer error diagnostics
    'https://github.com/MunifTanjim/nui.nvim',                       -- Component library, required by others
    'https://github.com/rcarriga/nvim-notify',                       -- Notifications
    'https://github.com/akinsho/bufferline.nvim',                    -- Better tabline
    'https://github.com/lukas-reineke/indent-blankline.nvim',        -- Adds indentation guides
    "https://github.com/goolord/alpha-nvim",                         -- Dashboard
    "https://github.com/folke/snacks.nvim",                          -- UI stuff
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",

    -- LSP stuff
    "https://github.com/nvimdev/lspsaga.nvim",         -- Additional lsp commands
    "https://github.com/pmizio/typescript-tools.nvim", -- Better ts handling
    "https://github.com/rafamadriz/friendly-snippets", -- Snippets
    -- "https://github.com/L3MON4D3/LuaSnip",             -- Snippets
    "https://github.com/Saghen/blink.cmp",             -- Snippet engine
    -- "https://github.com/windwp/nvim-ts-autotag",       -- Autoclose typescript tags [BROKEN]
    "https://github.com/m4xshen/autoclose.nvim",       -- Autoclose and open brackets and stuff
    "https://github.com/stevearc/conform.nvim",        -- Formatting
    "https://github.com/rust-lang/rust.vim",

    -- THEME setup
    "https://github.com/raddari/last-color.nvim",
    "https://github.com/Mofiqul/dracula.nvim",
    "https://github.com/catppuccin/nvim",
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/oxfist/night-owl.nvim",
    "https://github.com/vague2k/vague.nvim",
    "https://github.com/mcauley-penney/techbase.nvim",
})

--------------------- CORE PLUGINS ---------------------

require("mason").setup({
    PATH = "append",
})

require("outline").setup()
require("trouble").setup()
require("lualine").setup({
    theme = "bubbles",
})

vim.keymap.set('n', '<leader>nl', function()
    require('snacks').notifier.show_history()
end, { desc = "Notification History" })

vim.keymap.set('n', '<leader>nh', function()
    require('snacks').notifier.hide()
end, { desc = "Dismiss All Notifications" })

vim.keymap.set('n', '<leader>T', function()
    require('snacks').terminal()
end, { desc = "Toggle Terminal" })

require('notify').setup({
    background_colour = "#000000"
})

-- require('noice').setup({
--   presets = {
--     lsp_doc_border = true,
--     bottom_search = true,
--     command_palette = false
--   },
--
--   cmdline = {
--     view = "cmdline"
--   }
-- })

-- require("dbee").setup({
--   connections = {
--     {
--       name = "Tato",
--       type = "postgres",
--       url = "postgres://tatoadmin:password@localhost:5432/local"
--     }
--   },
-- })

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
    filters = {
        dotfiles = false
    },
    git = {
        ignore = false
    }
})

--------------------- VISUAL PLUGINS ---------------------
require("bufferline").setup({
    options = {
        mode = "tabs",
        diagnostics = "nvim_lsp",
        color_icons = true,
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
        get_element_icon = function(element)
            local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype,
                { default = false })
            return icon, hl
        end
    }
})

require('ibl').setup({})

require('tiny-inline-diagnostic').setup({
    preset = 'powerline',
})

--------------------- THEMES ---------------------
-- Set last used color using last-color
local theme = require("last-color").recall() or "catppuccin"
vim.cmd(("colorscheme %s"):format(theme))


--------------------- LSP ---------------------
require("lspsaga").setup({
    -- This is the breadcrumbs at the top of the buf, provided by another plugin
    symbol_in_winbar = {
        enable = false
    }
})

-- LUA
vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

vim.lsp.enable('lua_ls')

-- TYPESCRIPT
vim.lsp.config.vtsls = {
    cmd = { 'vtsls', '--stdio' },
    filetypes = {
        'typescript',
        'javascript',
        'typescriptreact',
        'javascriptreact',
        'vue'
    },
    root_markers = {
        'package.json',
        'tsconfig.json',
        'jsconfig.json',
        '.git'
    },
}

vim.lsp.enable('vtsls')

vim.lsp.config.eslint = {
    workingDirectory = { mode = "auto" },
    codeAction = {
        disableRuleComment = { enable = true },
        showDocumentation = { enable = true },
    },
    format = true, -- keep ESLint from being your formatter
}

vim.lsp.enable('eslint')

-- TAILWIND CSS
vim.lsp.config.tailwindcss = {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = {
        'astro',
        'astro-markdown',
        'django-html',
        'htmldjango',
        'eelixir',
        'elixir',
        'ejs',
        'gohtml',
        'gohtmltmpl',
        'handlebars',
        'hbs',
        'html',
        'html-eex',
        'heex',
        'markdown',
        'mdx',
        'css',
        'less',
        'postcss',
        'sass',
        'scss',
        'javascript',
        'javascriptreact',
        'rescript',
        'typescript',
        'typescriptreact',
        'vue',
        'svelte',
        'templ'
    },
    init_options = {
        userLanguages = {
            eelixir = "html-eex",
            eruby = "erb",
            templ = "html"
        }
    },
    settings = {
        tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            includeLanguages = {
                typescript = "javascript",
                typescriptreact = "javascript",
                ["html-eex"] = "html",
                ["phoenix-heex"] = "html",
                heex = "html",
                eelixir = "html",
                elm = "html",
                erb = "html",
                svelte = "html",
                templ = "html"
            },
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning"
            },
            validate = true
        }
    },
    root_markers = {
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'tailwind.config.ts',
        'postcss.config.js',
        'postcss.config.cjs',
        'postcss.config.mjs',
        'postcss.config.ts',
        'package.json',
        'node_modules',
        '.git'
    }
}

vim.lsp.enable('tailwindcss')

vim.lsp.config.pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git', 'uv.lock' },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true
            }
        }
    }
}

vim.lsp.enable('pyright')

-- vim.lsp.config("basedpyright", {
--   cmd = { "basedpyright-langserver", "--stdio" },
--   settings = {
--     basedpyright = {
--       analysis = {
--         typeCheckingMode = "strict", -- or "basic"/"off"
--         autoImportCompletions = true,
--       },
--     },
--   },
-- })

-- vim.lsp.enable("basedpyright")

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json' },
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
                -- Download and analyze dependencies
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
            -- Enable source code for dependencies
            rustc = {
                source = "discover",
            },
        },
    },
})

vim.lsp.enable('rust_analyzer')

require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        lua = { "lsp_format" },
        go = { "lsp_format" },
        python = { "lsp_format" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

-- Override vim.lsp.buf.format to use conform
vim.lsp.buf.format = function(opts)
    require("conform").format(opts)
end

--------------------- AUTOCOMPLETE ---------------------
require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
    keymap = {
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'accept', 'fallback' },
    }
})

require("autoclose").setup()

--------------------- KEYBINDS ---------------------
-- Tabs
vim.keymap.set("n", "<leader>[", ":tabprevious<CR>", {})
vim.keymap.set("n", "<leader>]", ":tabnext<CR>", {})

-- Extra binds for split keyboard
vim.keymap.set("n", "<leader>0", ":tabprevious<CR>", {})
vim.keymap.set("n", "<leader>-", ":tabnext<CR>", {})

-- Keybinds for telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {}) -- Open file finder
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, {})  -- Open grep
vim.keymap.set("n", "<leader>r", telescope_builtin.oldfiles, {})   -- Recent files

-- Inline file browser
local function open_file_browser()
    local telescope = require("telescope")
    local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
    end

    local w = vim.api.nvim_win_get_width(0)
    local h = vim.api.nvim_win_get_height(0)

    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cmd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = false,
        grouped = true,
        previewer = true,
        initial_mode = "normal",

        prompt_title = telescope_buffer_dir(),
        theme = "dropdown",
        layout_config = { height = h, width = w, prompt_position = "top" },
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
        selection_caret = "  ",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        file_icons = true,
        dir_icon = "󰉋"

    })
end

vim.keymap.set("n", "<leader>b", open_file_browser, {})

-- Open theme select
vim.keymap.set("n", "<leader>cs", ":Telescope colorscheme<CR>", {})

-- Misc
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>i", ":LazyGit<CR>", {})
vim.keymap.set("n", "<leader>o", ":Outline<CR>", {})
vim.keymap.set("n", "<leader>w", ":Trouble diagnostics<CR>", {}) -- Open warnings
vim.keymap.set("n", "<leader>fp", ":echo expand('%:p')<CR>", {}) -- Show filepath

-- LSP
vim.keymap.set("n", "<leader>1", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>2", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>3", "<cmd>Lspsaga code_action<CR>", {})
vim.keymap.set("n", "<leader>l", vim.lsp.buf.format, {})
vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pt", "<cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gtt", "<cmd>Lspsaga goto_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fa", "<cmd>Lspsaga finder<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lspi", "<cmd>LspInfo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lspr", "<cmd>LspRestart<CR>", { noremap = true, silent = true })

vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_respect_buf_cwd = 1
vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<Cr>", {})      -- Open explorer
vim.keymap.set("n", "<leader>ee", ":NvimTreeClose<Cr>", {})    -- Close explorer
vim.keymap.set("n", "<leader>ec", ":NvimTreeCollapse<Cr>", {}) -- Explorer collapse

--------------------- MISC ---------------------
-- Set 2 space tabstop for react
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "typescriptreact", "lua", "json", "yaml" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end
})

--------------------- DASHBOARD ---------------------
local arasaka_logo = {
    "                                               ",
    "                                               ",
    "                                               ",
    "                                               ",
    "                                               ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⡶⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⢀⣴⡾⠛⠉⢠⣶⣿⣿⣶⣄⠉⠛⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⣠⣿⠋⠀⠀⠀⣿⣿⣿⣿⣿⣿⠀⠀⠀⠙⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⢠⣿⢣⣴⣶⣶⣦⡹⢿⣿⣿⡿⢏⣴⣶⣶⣦⡜⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⣼⡏⣿⣿⣿⣿⣿⣿⠀⣿⡿⠀⣿⣿⣿⣿⣿⣿⢸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⢿⡇⠻⣿⣿⣿⣿⣿⡀⣽⣿⢀⣽⣿⣿⣿⣿⠟⢸⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠸⣿⡀⠈⠉⠉⠉⠻⣿⣿⣿⣾⠟⠁⠉⠉⠁⠀⣾⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠹⣷⡀⠀⠀⠀⠀⠈⣿⣿⠁⠀⠀⠀⠀⢀⣾⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠘⢿⣦⣄⠀⠀⠀⣽⣷⠀⠀⠀⣠⣴⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⢷⣶⣾⣷⣶⡶⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⣀⣀⡀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⣀⣀⡀⠀⠀⣀⡀⠀⢀⣀⠀⠀⣀⣀⡀⠀⠀",
    "⣴⣿⠟⠛⢿⣦⡀⣿⡟⠛⠛⠛⣿⣷⣴⣿⠟⠛⢿⣦⡀ ⣠⣾⡻⠻⠗⠀⣴⣿⠟⠛⢿⣦⡀⣿⣧⣾⡿⠛⣴⣿⠟⠛⢿⣦⡀",
    "⣿⡇⠀⠀⠀⣿⡇⣿⣷⣄⡀⠀⠉⠁⣿⡇⠀⠀⠀⣿⡇⣀⡉⠻⢿⣶⣄ ⣿⡇⠀⠀⠀⣿⡇⣿⣿⣄  ⣿⡇⠀⠀⠀⣿⡇",
    "⠙⠿⣷⣶⡦⣿⡇⣿⡇⠛⢿⣷⣤⡀⠙⠿⣷⣶⡦⣿⡇⢿⣷⣶⣶⣿⣿⣿⠙⠿⣷⣶⡦⣿⡇⣿⠋⠻⢿⣶⠙⠿⣷⣶⡦⣿⡇",
    "                                               ",
}

vim.api.nvim_create_user_command("MLOpenFileBrowser", open_file_browser, {});

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = arasaka_logo

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
            dashboard.button("b", "󰉋   Browse files", ":MLOpenFileBrowser<CR>"),
            dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "   Settings", ":cd ~/dotfiles<CR> | :e ./nvim/init.lua<CR>"),
            dashboard.button("q", "󰗼   Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
    end,
})

-- Launch alpha if no paths
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            require("alpha").start()
        end
    end,
})

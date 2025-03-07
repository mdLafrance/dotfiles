-- Plugins related to ide config

return {
    -- Grab bag of upgrades
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = false }
        },
        keys = {
            { "<leader>nl", function() Snacks.notifier.show_history() end, desc = "Notification History" },
            { "<leader>nh", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
            { "<leader>T",  function() Snacks.terminal() end,              desc = "Toggle Terminal" },
        }
    },

    -- -- File explorer
    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     lazy = false,
    --     dependencies = {
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     config = function()
    --         require("nvim-tree").setup({
    --             update_cwd = true,
    --             update_focused_file = {
    --                 enable = true,
    --                 update_cwd = false,
    --             },
    --             diagnostics = {
    --                 enable = true,
    --                 show_on_dirs = true,
    --             },
    --             filters = {
    --                 dotfiles = false
    --             },
    --             git = {
    --                 ignore = false
    --             }
    --         })
    --     end
    -- },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-tree/nvim-web-devicons"
        },
        config = function(_, opts)
            print("Opts?", vim.inspect(opts))
            local fb_actions = require("telescope").extensions.file_browser.actions

            opts.defaults = {
                -- wrap_results = true,
                -- layout_strategy = "horizontal",
                -- layout_config = { prompt_position = "top" },
                -- sorting_strategy = "ascending",
                -- winblend = 0,
                file_ignore_patterns = { ".git", "node_modules", ".cache" },
            }

            opts.pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                    layout_config = {
                        height = 0.70,
                    },
                },
                buffers = {
                    show_all_buffers = true,
                },
                live_grep = {
                    previewer = false,
                    theme = "dropdown",
                },
                git_status = {
                    git_icons = {
                        added = " ",
                        changed = " ",
                        copied = " ",
                        deleted = " ",
                        renamed = "➡",
                        unmerged = " ",
                        untracked = " ",
                    },
                    previewer = false,
                    theme = "dropdown",
                },
                colorscheme = {
                    enable_preview = true,
                },
            }

            opts.extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                file_browser = {
                    theme = "dropdown",
                    hijack_netrw = true,
                    file_icons = true,
                    folder_icons = true,
                    mappings = {
                        ["n"] = {
                            ["h"] = fb_actions.goto_parent_dir,
                            ["c"] = fb_actions.goto_cwd,
                            ["o"] = fb_actions.change_cwd,
                            ["a"] = fb_actions.create,
                            ["l"] = require("telescope.actions").select_default,
                            ["<C-h>"] = fb_actions.toggle_hidden,
                            ["<C-n>"] = fb_actions.create,
                            ["<C-u"] = fb_actions.goto_home_dir,
                            ["<C-v>"] = require("telescope.actions").select_vertical,
                            ["<C-s>"] = require("telescope.actions").select_horizontal,
                            ["<C-t>"] = require("telescope.actions").select_tab,
                        }
                    }

                }
            }

            require("telescope").setup(opts)
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("file_browser")
        end,
    },

    -- Lazygit
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()

        end
    },

    -- Opens a window with code issues
    {
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
    },

    -- Bottom bar with information about line, file type etc
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                theme = "bubbles",
                -- sections = {
                --     lualine_a = { 'mode' },
                --     lualine_b = { 'branch', 'diff', 'diagnostics' },
                --     lualine_c = { 'filename' },
                --     lualine_x = { 'filetype' },
                --     -- lualine_y = { 'progress' },
                --     lualine_y = { "require'lsp-status'.status()" },
                --     lualine_z = { 'location' }
                -- },
            })
        end
    },

    -- Bufferline - better tabline formatting
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
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
        end
    },

    -- Adds visual guides for indented lines
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    -- An icon picker
    -- {
    --     "ziontee113/icon-picker.nvim",
    --     config = function()
    --         require("icon-picker").setup({ disable_legacy_commands = true })
    --     end
    -- },

    -- Switches line number between relative/absolute
    {
        'sitiom/nvim-numbertoggle'
    },

    -- Adds additional visual indicators when selecting pane
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function()
            require("window-picker").setup()
        end,
    },

    -- Shows hints to key chords
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

    -- Updates the ui a little bit
    {
        "stevearc/dressing.nvim",
        opts = {},
    },

    -- Saves the last used color scheme
    {
        "raddari/last-color.nvim"
    },

    -- Opens Markdown files
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup({
                auto_load = true,
                syntax = true,
                theme = "dark",
                update_on_change = true,
                app = { "firefox", "--new-window" },
            })
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },

    -- Additional popup styling
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        event = 'VeryLazy',
        opts = {
            presets = {
                lsp_doc_border = true,
                bottom_search = true,
                command_palette = false
            },

            cmdline = {
                view = "cmdline"
            }
        },
    },

    -- Popup messages
    {
        "rcarriga/nvim-notify",

        config = function(_, opts)
            require('notify').setup(vim.tbl_extend('keep', {
                -- other stuff
                background_colour = "#000000"
            }, opts))
        end
    },

    -- Transparent background
    { "xiyaowong/transparent.nvim" },

    -- Menu
    { "nvzone/volt",                         lazy = true },
    { "nvzone/menu",                         lazy = true },
}

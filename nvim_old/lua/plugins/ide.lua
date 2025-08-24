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
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
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
        filters = {
          dotfiles = false
        },
        git = {
          ignore = false
        }
      })
    end
  },

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

  -- Bufferline - better tabline (topbar) formatting
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

  {
    "mdlafrance/flip.nvim",
    opts = { debug = false },
    dependencies = {
      "MunifTanjim/nui.nvim"
    }
  },

  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = { enabled = false },
  },

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
      {
        "MattiasMTS/cmp-dbee",
        dependencies = {
          { "kndndrj/nvim-dbee" }
        },
        ft = "sql", -- optional but good to have
        opts = {},  -- needed
      },
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
          { "cmp-dbee" },

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
          cc = { "astyle" },
          typescript = { "prettierd", "prettier" },
          typescriptreact = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = false,
        },
        formatters = {
          prettier = {
            command = "prettier",
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" }
          }
        }
      })
    end,
  },

  -- Additional formatting
  -- {
  --     "nvimtools/none-ls.nvim",
  --     config = function()
  --         local null_ls = require("null-ls")
  --         null_ls.setup({
  --             sources = {
  --                 null_ls.builtins.formatting.stylua,
  --                 null_ls.builtins.formatting.gofmt,
  --                 null_ls.builtins.formatting.goimports,
  --                 null_ls.builtins.formatting.black,
  --                 null_ls.builtins.formatting.clang_format,
  --                 null_ls.builtins.formatting.cmake_format,
  --                 null_ls.builtins.formatting.fixjson,
  --                 null_ls.builtins.formatting.rustfmt,
  --                 null_ls.builtins.formatting.eslint_d, -- Javscript
  --             },
  --         })
  --     end,
  -- },

  -- Auto bracket closing
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require("autoclose").setup()
    end
  },

  -- Postgres client
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
        connections = {
          {
            name = "Tato",
            type = "postgres",
            url = "postgres://tatoadmin:password@localhost:5432/local"
          }
        },

      })
    end,
  },

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }
}

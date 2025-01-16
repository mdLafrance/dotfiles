-- Settings for nvimtree
vim.g.nvim_tree_respect_buf_cwd = 1

vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<Cr>", {})      -- Open explorer
vim.keymap.set("n", "<leader>ee", ":NvimTreeClose<Cr>", {})    -- Close explorer
vim.keymap.set("n", "<leader>ec", ":NvimTreeCollapse<Cr>", {}) -- Explorer collapse

-- Settings for terminal
vim.keymap.set("n", "<leader>t", ":Lspsaga term_toggle<Cr>", {}) -- Open terminal

-- Settings for telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {}) -- Open file finder
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, {})  -- Open grep

-- Open trouble - warnings and errors pane
vim.keymap.set("n", "<leader>w", ":TroubleToggle<CR>", {}) -- Open warnings

-- Open lazygit
vim.keymap.set("n", "<leader>i", ":LazyGit<CR>", {})

-- Total quit
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", {})

-- Start markdown preivew
vim.keymap.set("n", "<leader>md", ":PeekOpen<CR>", {})

-- This function is a bit of a workaround for css-in-js
-- cssls attaches to tsx files to provide lsp support, but it
-- also gets called when formatting. This file is a hook that
-- filters out cssls if we're in a tsx file.
local function custom_format()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype

    -- Get all active clients for the current buffer
    local clients = vim.lsp.buf_get_clients(bufnr)

    -- Filter out cssls for tsx files
    if filetype ~= "css" then
        clients = vim.tbl_filter(function(client)
            return client.name ~= "cssls"
        end, clients)
    end

    -- Filter out html for templ files
    if filetype ~= "html" then
        clients = vim.tbl_filter(function(client)
            return client.name ~= "html"
        end, clients)
    end

    -- Call formatting
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            -- Use the filtered clients list
            return vim.tbl_contains(clients, client)
        end,
    })
end

-- Call format
vim.keymap.set("n", "<leader>l", custom_format, {})

-- Open theme select
vim.keymap.set("n", "<leader>cs", ":Telescope colorscheme<CR>", {})

-- Open Mason
vim.keymap.set("n", "<leader>m", ":Mason<CR>", {})

-- Open Lazy
vim.keymap.set("n", "<leader>L", ":Lazy<CR>", {})

-- Open error messages
vim.keymap.set("n", "<leader>err", ":messages<CR>", {})

-- Comment/uncomment selected lines
-- 'gc' in visual select mode

-- Open outliner
vim.keymap.set("n", "<leader>o", ":Lspsaga outline<CR>", {})

-- LSP
-- vim.keymap.set("n", "<leader>1", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>1", require("pretty_hover").hover, {})
vim.keymap.set("n", "<leader>2", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>3", vim.lsp.buf.code_action, {})
vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pt", "<cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gtt", "<cmd>Lspsaga goto_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fa", "<cmd>Lspsaga finder<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lspi", "<cmd>LspInfo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lspr", "<cmd>LspRestart<CR>", { noremap = true, silent = true })

-- Menu
vim.keymap.set("n", "<RightMouse>", function()
    vim.cmd.exec '"normal! \\<RightMouse>"'

    local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
    require("menu").open(options, { mouse = true })
end, {})

-- Tabby
vim.keymap.set("n", "<leader>nt", ":TabbyNewTab<CR>", {})
vim.keymap.set("n", "<leader>cl", ":TabbyCloseTab<CR>", {})

vim.keymap.set("n", "<leader>[", ":TabbyPreviousTab<CR>", {})
vim.keymap.set("n", "<leader>]", ":TabbyNextTab<CR>", {})

vim.keymap.set("n", "<leader>tdr", ":TabbyDetach right<CR>", {})
vim.keymap.set("n", "<leader>tdd", ":TabbyDetach below<CR>", {})
vim.keymap.set("n", "<leader>tmr", ":TabbyMerge right<CR>", {})
vim.keymap.set("n", "<leader>tml", ":TabbyMerge left<CR>", {})

-- Flip
vim.keymap.set("n", "<leader>fb", ":FlipBack<CR>", {})
vim.keymap.set("n", "<leader>fh", ":FlipToRecent<CR>", {})

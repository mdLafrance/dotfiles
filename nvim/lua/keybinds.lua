-- Settings for nvimtree
vim.g.nvim_tree_respect_buf_cwd = 1

vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<Cr>", {}) -- Open grep
vim.keymap.set("n", "<leader>ee", ":NvimTreeClose<Cr>", {}) -- Open grep

-- Settings for terminal
vim.keymap.set("n", "<leader>t", ":Lspsaga term_toggle<Cr>", {}) -- Open grep

-- Settings for telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {}) -- Open file finder
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, {}) -- Open grep

-- Open trouble - warnings and errors pane
vim.keymap.set("n", "<leader>w", ":TroubleToggle<CR>", {}) -- Open file finder

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

	-- Call formatting
	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			-- Use the filtered clients list
			return vim.tbl_contains(clients, client)
		end,
	})
end

local templ_format = function()
    if vim.bo.filetype == "templ" then
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = templ_format })

-- Lint
vim.keymap.set("n", "<leader>l", custom_format, {})

-- Enable format on save using LSP
vim.cmd([[autocmd BufWritePre *.cpp,*.h lua custom_format()]])

-- Open theme select
vim.keymap.set("n", "<leader>cs", ":Telescope colorscheme<CR>", {})

-- Open mason
vim.keymap.set("n", "<leader>m", ":Mason<CR>", {})

-- Open error messages
vim.keymap.set("n", "<leader>err", ":messages<CR>", {})

-- Comment/uncomment selected lines
-- 'gc' in visual select mode

-- Open outliner
vim.keymap.set("n", "<leader>o", ":Lspsaga outline<CR>", {})

vim.api.nvim_set_keymap('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pt', '<cmd>Lspsaga peek_type_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gtt', '<cmd>Lspsaga goto_type_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Lspsaga finder<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lspr', '<cmd>LspRestart<CR>', { noremap = true, silent = true })


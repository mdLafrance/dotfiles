-- Settings for nvimtree
vim.g.nvim_tree_respect_buf_cwd = 1

vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<Cr>", {})  -- Open grep
vim.keymap.set("n", "<leader>ee", ":NvimTreeClose<Cr>", {}) -- Open grep

-- Settings for terminal
vim.keymap.set("n", "<leader>t", function()
    require("nvterm.terminal").toggle("float")
end, {}) -- Open grep

-- Settings for telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {}) -- Open file finder
vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, {})  -- Open grep

-- Open trouble - warnings and errors pane
vim.keymap.set("n", "<leader>w", ":TroubleToggle<CR>", {}) -- Open file finder

-- Open lazygit
vim.keymap.set("n", "<leader>i", ":LazyGit<CR>", {})

-- Total quit
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", {})

-- Start markdown preivew
vim.keymap.set("n", "<leader>md", ":MarkdownPreview<CR>", {})

-- Lint
vim.keymap.set("n", "<leader>l", vim.lsp.buf.format, {})
-- Enable format on save using LSP
vim.cmd([[autocmd BufWritePre *.cpp,*.h lua vim.lsp.buf.format()]])


-- Open theme select
vim.keymap.set("n", "<leader>cs", ":Telescope colorscheme<CR>", {})

-- Open mason
vim.keymap.set("n", "<leader>m", ":Mason<CR>", {})

-- Open error messages
vim.keymap.set("n", "<leader>err", ":messages<CR>", {})

-- Comment/uncomment selected lines
-- 'gc' in visual select mode

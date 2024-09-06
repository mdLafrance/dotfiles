-- Settings for nvimtree
vim.g.nvim_tree_respect_buf_cwd = 1

vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<Cr>", {})  -- Open grep
vim.keymap.set("n", "<leader>ee", ":NvimTreeClose<Cr>", {}) -- Open grep

-- Settings for terminal
vim.keymap.set("n", "<leader>t", ":Lspsaga term_toggle<Cr>", {}) -- Open grep

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
vim.keymap.set("n", "<leader>md", ":PeekOpen<CR>", {})

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

-- Open outliner
vim.keymap.set("n", "<leader>o", ":Lspsaga outline<CR>", {})

-- Extra lsp 
vim.api.nvim_set_keymap('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pt', '<cmd>Lspsaga peek_type_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gtt', '<cmd>Lspsaga goto_type_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Lspsaga finder<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lspr', '<cmd>LspRestart<CR>', { noremap = true, silent = true })


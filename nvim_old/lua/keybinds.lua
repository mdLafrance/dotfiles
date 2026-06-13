-- Vim settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Settings for nvimtree
vim.g.nvim_tree_auto_open = 0
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
vim.keymap.set("n", "<leader>r", telescope_builtin.oldfiles, {}) -- Recent files

-- Telescope file browser
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
  local clients = vim.lsp.get_clients(bufnr)

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
vim.keymap.set("n", "<leader>o", ":Outline<CR>", {})

-- LSP
-- vim.keymap.set("n", "<leader>1", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>1", require("pretty_hover").hover, {})
vim.keymap.set("n", "<leader>2", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>3", vim.lsp.buf.code_action, {})
vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pt", "<cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
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


-- Tabs
vim.keymap.set("n", "<leader>[", ":tabprevious<CR>", {})
vim.keymap.set("n", "<leader>]", ":tabnext<CR>", {})

-- Extra binds for split keyboard
vim.keymap.set("n", "<leader>0", ":tabprevious<CR>", {})
vim.keymap.set("n", "<leader>-", ":tabnext<CR>", {})

-- -- Tabby
-- vim.keymap.set("n", "<leader>nt", ":TabbyNewTab<CR>", {})
-- vim.keymap.set("n", "<leader>cl", ":TabbyCloseTab<CR>", {})
--
-- vim.keymap.set("n", "<leader>[", ":TabbyPreviousTab<CR>", {})
-- vim.keymap.set("n", "<leader>]", ":TabbyNextTab<CR>", {})
--
-- vim.keymap.set("n", "<leader>tdr", ":TabbyDetach right<CR>", {})
-- vim.keymap.set("n", "<leader>tdd", ":TabbyDetach below<CR>", {})
-- vim.keymap.set("n", "<leader>tmr", ":TabbyMerge right<CR>", {})
-- vim.keymap.set("n", "<leader>tml", ":TabbyMerge left<CR>", {})

-- Flip
vim.keymap.set("n", "<leader>fb", ":FlipBack<CR>", {})
vim.keymap.set("n", "<leader>fh", ":FlipToRecent<CR>", {})

-- Custom stuff

-- Insert before/after
vim.keymap.set("v", "<leader>s", function()
  local bufnr = 0

  -- Prompt for text to insert
  vim.ui.input({ prompt = "Enter text to insert before/after: " }, function(user_input)
    if not user_input then return end -- cancelled

    local text_length = #user_input

    local start_pos = vim.api.nvim_buf_get_mark(bufnr, "<")
    local end_pos = vim.api.nvim_buf_get_mark(bufnr, ">")

    local start_line = start_pos[1] - 1
    local start_col = start_pos[2]
    local end_line = end_pos[1] - 1
    local end_col = end_pos[2]

    if
        start_line > end_line or
        (start_line == end_line and start_col > end_col)
    then
      start_line, end_line = end_line, start_line
      start_col, end_col = end_col, start_col
    end

    -- Insert the user-specified text
    vim.api.nvim_buf_set_text(bufnr, end_line, end_col + 1, end_line, end_col + 1, { user_input })
    vim.api.nvim_buf_set_text(bufnr, start_line, start_col, start_line, start_col, { user_input })

    -- Move cursor and exit visual mode
    vim.api.nvim_win_set_cursor(0, { start_line + text_length, start_col })
  end)
end, { desc = "Surround visual selection" }) -- no mode here

vim.keymap.set("v", "<leader>[", function()
  -- Save the buffer number
  local bufnr = vim.api.nvim_get_current_buf()

  -- Schedule so the visual marks < and > are still valid
  vim.schedule(function()
    -- Get visual selection marks (1-indexed)
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    local start_line = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_line = end_pos[2] - 1
    local end_col = end_pos[3] - 1

    -- Normalize positions (visual selection can be backwards)
    if start_line > end_line or (start_line == end_line and start_col > end_col) then
      start_line, end_line = end_line, start_line
      start_col, end_col = end_col, start_col
    end

    -- Get text and join it for safe replacement
    local lines = vim.api.nvim_buf_get_text(bufnr, start_line, start_col, end_line, end_col + 1, {})
    local wrapped = "[" .. table.concat(lines, "\n") .. "]"

    -- Replace selected text with wrapped text
    vim.api.nvim_buf_set_text(bufnr, start_line, start_col, end_line, end_col + 1, { wrapped })

    -- Safely place cursor at start
    local new_lines = vim.api.nvim_buf_line_count(bufnr)
    if start_line + 1 <= new_lines then
      local new_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ""
      local safe_col = math.min(start_col, #new_line)
      vim.api.nvim_win_set_cursor(0, { start_line + 1, safe_col })
    end

    -- Exit visual mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end)
end, {
  desc = "Surround visual selection with brackets",
})

-- Set indentation for react
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "lua", "json", "yaml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end
})

-- Dbee
vim.keymap.set("n", "<leader>pg", require("dbee").toggle, {})

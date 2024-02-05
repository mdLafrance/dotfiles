--
-- Some specific rebindings etc for vim
--

-- Indents
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set mouse able to drag windows
vim.opt.mouse = "a"

-- Adds extra spacing to the left of linenumber
-- This is so that icons (like lightbulb for code actions) always have space
-- reserved. Otherwise, these icons popping in and out causes the screen to shake
-- sideways.
vim.opt.signcolumn = "yes"

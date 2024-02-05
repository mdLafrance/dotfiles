---@diagnostic disable: undefined-global

-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- NOTE: specifically mapleader needs to be rebound before lazy is loaded

require("lazy").setup("plugins")

-- Custom vim keybinds and config
require("vim")
require("keybinds")

-- Set last used color using last-color
local theme = require("last-color").recall() or "catppuccin"
vim.cmd(("colorscheme %s"):format(theme))

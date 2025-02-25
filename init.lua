-- Custom keybindings
require("remaps")

-- Global editor settings and functions
require("settings")
require("functions")

-- Bootstrap lazy if it is not installed yet.
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

-- Load Lua plugins from the plugins/ directory.
require("lazy").setup("plugins")

-- Global options (maybe be moved in the future)
-- Register the "nice-references" plugin to handle LSP "references" calls.
vim.lsp.handlers["textDocument/references"] = require "nice-reference".reference_handler

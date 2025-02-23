if vim.g.vscode then
    -- VS Code extension
    require("remaps")
    require("plugins.vscode")
    require("functions")
else
    -- Ordinary Neovim

    -- File explorer (nvim-tree) settings.
    -- It is strongly recommended to disable netrw. As it is a bundled plugin it
    -- must be disabled manually at the start of the "init.lua".
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Custom keybindings
    require("remaps")

    -- Editor settings
    require("settings")
    require("functions")

    -- Configure plugins
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
end

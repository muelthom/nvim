-- Custom keybindings
require("remaps")

-- Global editor settings and functions
require("settings")
require("functions")

-- Bootstrap lazy if it is not installed yet.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load Lua plugins from the plugins/ directory.
require("lazy").setup("plugins")

vim.opt.completeopt = { "menuone", "noinsert", "popup", "fuzzy" }
vim.keymap.set("i", "<c-space>", function()
    vim.lsp.completion.get()
end)

-- Configure builtin auto-completion
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- Enable LSP configurations present on the runtimepath (https://neovim.io/doc/user/options.html#'runtimepath').
vim.lsp.enable({
    "lua_ls",
    "clangd",
    "pylsp",
})

-- "Set" directives (editor settings)
vim.opt.syntax = "on"
vim.opt.termguicolors = true

-- Interface options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 6
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%l%s"
vim.opt.winborder = "rounded"

-- Create an augroup for Python
vim.api.nvim_create_augroup("Python", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "Python",
    pattern = "python",
    callback = function()
        vim.opt.colorcolumn = "88"
    end,
})

-- Create an augroup for C and C++
vim.api.nvim_create_augroup("CC", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "CC",
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt.colorcolumn = "100"
    end,
})

-- Diagnostics
vim.diagnostic.config({
    virtual_text = { current_line = true },
    float = {
        border = "rounded",
        focusable = true,
        header = "",
        prefix = "",
        source = true,
        style = "minimal",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
})

-- Indent options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Spell checking
-- See: https://johncodes.com/posts/2023/02-25-nvim-spell/
vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.list = true
vim.opt.listchars = {
    -- eol = "↵",
    -- lead = '·',
    nbsp = "␣",
    tab = ">-",
    trail = "·",
}

-- Highlight when yanking (copying) text.
-- Try it with "yap" in normal mode.
-- See ":help vim.highlight.on_yank()"
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

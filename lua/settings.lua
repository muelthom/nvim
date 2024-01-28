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
vim.opt.colorcolumn = "80,100"

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

vim.cmd 'colorscheme habamax'

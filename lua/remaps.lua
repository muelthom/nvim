vim.g.mapleader = " "

-- Keep the highlighted lines after indenting.
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move highlighted lines up/down. They will be indented automatically.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J takes the line below and apends it to the current line with a space character.
-- This remap ensures the cursor stays in front when doing so.
vim.keymap.set("n", "J", "mzJ`z")

-- Center the view when scrolling up/down page.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Let search terms stay centered in the screen.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Delete the current highlighted word into the void register to preserve the previous yank.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yanks to the + register (which is also the system clipboard).
-- This effectively still keeps a separation between the Neovim and the system clipboard.
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

-- Unmap Q.
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %", { noremap = true, silent = true })
vim.keymap.set("c", "x!!", "w !chmod +x %", { noremap = true, silent = true })

-- Turn off highlighting until the next search.
vim.keymap.set("n", "<ESC>", "v:hlsearch ? ':nohl<CR>' : '<ESC>'", { expr = true, silent = true })

-- Select the whole file contents ("select all").
vim.keymap.set("n", "<leader>sa", "ggVG")

-- Search and replace the word under the cursor.
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Cycle through open buffers (left, right).
-- vim.keymap.set({ "n", "v" }, "<C-j>", ":bnext<CR>")
-- vim.keymap.set({ "n", "v" }, "<C-k>", ":bprev<CR>")

-- Vertical equivalent of "<C-w>n" (create a new horizontal split with an empty buffer).
vim.keymap.set({ "n", "v", "i" }, "<C-w>N", ":vnew<CR>")

vim.keymap.set({ "n", "v" }, "<leader>n", ":bnext<CR>")
vim.keymap.set({ "n", "v" }, "<leader>N", ":bprev<CR>")
vim.keymap.set({ "n", "v" }, "<leader>d", ":bnext<CR>")

vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:CFloatTerm<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Cwdf",
    function()
        vim.cmd(":cd %:h")
    end,
    { desc = "Change cwd to that of the currently opened file." }
)

vim.api.nvim_set_keymap("n", "!", ":lua invert_word()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>rl", function()
    vim.o.relativenumber = not vim.o.relativenumber
    if vim.o.relativenumber then
        vim.notify("Set relative line numbers", vim.log.levels.INFO, { title = "Relative Line Numbers" })
    else
        vim.notify("Unset relative line numbers", vim.log.levels.INFO, { title = "Relative Line Numbers" })
    end
end, { desc = "Toggle Relative Number", silent = true })

vim.keymap.set("n", "<leader>ww", function()
    vim.wo.wrap = not vim.wo.wrap
    if vim.wo.wrap then
        vim.notify("Set word wrap", vim.log.levels.INFO, { title = "Line Wrap" })
    else
        vim.notify("Unset word wrap", vim.log.levels.INFO, { title = "Line Wrap" })
    end
end, { desc = "Toggle Wrap", silent = true })

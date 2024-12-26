vim.g.mapleader = " "

-- Remap the "Ex"plore command
vim.keymap.set("n", "<leader>x", ":NvimTreeToggle<CR>", { silent = true, noremap = true })

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

-- Turn off highlighting until the next search.
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- Select the whole file contents ("select all").
vim.keymap.set("n", "<leader>sa", "ggVG")

-- Format code.
vim.keymap.set("n", "<leader>fc", "ggVG= :echomsg 'Formatted code.'<CR>")

-- Search and replace the word under the cursor.
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Cyle through open buffers (left, right).
vim.keymap.set({ "n", "v" }, "<C-j>", ":bnext<CR>")
vim.keymap.set({ "n", "v" }, "<C-k>", ":bprev<CR>")

-- Vertical equivalent of "<C-w>n" (create a new horizontal split with an empty buffer).
vim.keymap.set({ "n", "v", "i" }, "<C-w>N", ":vnew<CR>")

vim.keymap.set({ "n", "v" }, "<leader>n", ":bnext<CR>")
vim.keymap.set({ "n", "v" }, "<leader>N", ":bprev<CR>")
vim.keymap.set({ "n", "v" }, "<leader>d", ":bnext<CR>")

vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:CFloatTerm<CR>", { noremap = true, silent = true })

-- Use "cwdf" for "change working directory to currently opened file".
vim.api.nvim_create_user_command("CWDF",
    function(args)
        vim.cmd(":cd %:h")
    end,
    { desc = "Change cwd to that of the currently opened file." }
)

vim.api.nvim_set_keymap("n", "!", ":lua invert_word()<CR>", { noremap = true, silent = true })

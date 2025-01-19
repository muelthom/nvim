return {
    "petertriho/nvim-scrollbar",
    cond = true,
    opts = {
        function() require("nvim-scrollbar") end,
        show = true,
        set_highlights = true,
    },
    dependencies = {
        { "kevinhwang91/nvim-hlslens", },
        { "lewis6991/gitsigns.nvim", },
    },
    config = function()
        -- show = true,
        -- set_highlights = true,

        require("hlslens").setup({
            nearest_only = true,
            nearest_float_when = true
        })
        local kopts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]], kopts)

        require("scrollbar.handlers.search").setup({
            -- hlslens config overrides
        })
        require("gitsigns").setup()
        require("scrollbar.handlers.gitsigns").setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Keymaps: https://github.com/lewis6991/gitsigns.nvim#keymaps
                -- Mnemonic "toggle blame"
                map("n", "<leader>tb", gs.toggle_current_line_blame)
            end
        })
    end,
}

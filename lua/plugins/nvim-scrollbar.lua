return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        { "kevinhwang91/nvim-hlslens" },
        { "lewis6991/gitsigns.nvim" },
    },
    config = function()
        local kopts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]], kopts)
        vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]], kopts)

        require("scrollbar").setup({
            max_lines = 2000,
            show_in_active_only = true,
            hide_if_all_visible = false, -- Hides everything if all lines are visible
        })

        require("hlslens").setup({
            nearest_only = true,
            nearest_float_when = true,
        })

        require("gitsigns").setup({
            on_attach = function()
                -- Keymaps: https://github.com/lewis6991/gitsigns.nvim#keymaps
                -- Mnemonic "toggle blame"
                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame)
            end,
        })
    end,
}

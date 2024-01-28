return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",     -- Optional: for git status
        "nvim-tree/nvim-web-devicons", -- Optional: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        icons = {
            filetype = {
                enabled = false,
            }
        }
    }
}

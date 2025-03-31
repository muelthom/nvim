return {
    "wiliamks/nice-reference.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Optional
        {
            "rmagatti/goto-preview",
            config = function()
                require("goto-preview").setup({})
            end,
        },
    },
}

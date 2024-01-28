return {
    "wiliamks/nice-reference.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional
        {
            "rmagatti/goto-preview",
            opts = { function()
                require("goto-preview").setup {}
            end }
        }
    }
}

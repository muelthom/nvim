return {
    "wiliamks/nice-reference.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Optional
        {
            "rmagatti/goto-preview",
            dependencies = { "rmagatti/logger.nvim" },
            event = "BufEnter",
            config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
        },
    },
}

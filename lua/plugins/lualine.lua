return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            icons_enabled = true,
            show_filename_only = false,
            path = 3,
            theme = "auto", -- Automatically attempts to load a theme for the current colorscheme
        }
    }
}

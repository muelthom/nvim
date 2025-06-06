return {
    "w0ng/vim-hybrid",
    config = function()
        vim.cmd("colorscheme hybrid")

        local warmOrange = "#d7af87"
        local mutedGreen = "#d7af87"
        local softBlue = "#d7af87"
        local gentleYellow = "#d7af87"

        vim.api.nvim_set_hl(0, "SpellBad", { fg = "NONE", bg = "NONE", underdashed = true }) -- soft warm orange/tan
        vim.api.nvim_set_hl(0, "SpellCap", { fg = "NONE", bg = "NONE", underdashed = true }) -- muted green
        vim.api.nvim_set_hl(0, "SpellRare", { fg = "NONE", bg = "NONE", underdashed = true }) -- soft blue
        vim.api.nvim_set_hl(0, "SpellLocal", { fg = "NONE", bg = "NONE", underdashed = true }) -- gentle yellow
    end,
}

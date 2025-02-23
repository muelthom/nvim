return {
    "jacoborus/tender.vim",
    config = function()
        vim.cmd("colorscheme tender")

        -- Docstring
        vim.api.nvim_set_hl(0, "Docstring", { fg = "grey" })

        -- Italic comments
        vim.api.nvim_set_hl(0, "Comment", { fg = "grey", italic = true })

        -- Italic todo
        vim.api.nvim_set_hl(0, "Todo", { fg = "darkblue", italic = true })
    end
}

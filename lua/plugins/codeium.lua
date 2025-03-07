return {
    "Exafunction/codeium.nvim",
    enabled = false, -- Disabled by default
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({})
    end
}

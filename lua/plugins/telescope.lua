return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
            desc = "Find File",
        },
        {
            "<leader>fs",
            function()
                require("telescope.builtin").grep_string({
                    cwd = require("lazy.core.config").options.root,
                    search =
                        vim.fn.input("Grep > ")
                })
            end,
            desc = "Find String",
        },
        {
            "<leader>fg",
            function() require("telescope.builtin").git_files({ cwd = require("lazy.core.config").options.root }) end,
            desc = "Find Git File",
        },
        {
            "<leader>fb",
            function() require("telescope.builtin").buffers({ cwd = require("lazy.core.config").options.root }) end,
            desc = "Find Buffer",
        },
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    -- map actions.which_key to <C-h> (default: <C-/>)
                    -- actions.which_key shows the mappings for your picker,
                    -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    ["<C-h>"] = "which_key"
                }
            },
            file_ignore_patterns = {
                "*.pdf",
                "*.otf",
            }
        },
        pickers = {
            find_files = {
                hidden = true
            }
        },
        extensions = {}
    }
}

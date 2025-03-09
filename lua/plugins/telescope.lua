return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files() end,
            desc = "Find files in cwd",
        },
        {
            "<leader>fs",
            function()
                require("telescope.builtin").grep_string({
                    cwd = require("telescope.utils").buffer_dir(),
                    search =
                        vim.fn.input("Grep > ")
                })
            end,
            desc = "Find string",
        },
        {
            "<leader>fg",
            function() require("telescope.builtin").git_files({ cwd = require("telescope.utils").buffer_dir() }) end,
            desc = "Find Git files",
        },
        {
            "<leader>fb",
            function() require("telescope.builtin").buffers() end,
            desc = "Find buffers",
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

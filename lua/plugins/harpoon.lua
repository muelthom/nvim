return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        lazy = false,
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("harpoon").setup({
                settings = {
                    save_on_toggle = true
                }
            })
        end,
        keys = {
            {
                "<leader>a",
                function() require("harpoon"):list():add() end,
                desc = "Harpoon current buffer",
            },
            {
                "<C-b>",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Open Harpoon quick menu",
            },
            {
                "<leader>+",
                function() require("harpoon"):list():select(1) end,
                desc = "Harpoon to buffer 1",
            },
            {
                "<leader>[",
                function() require("harpoon"):list():select(2) end,
                desc = "Harpoon to buffer 2",
            },
            {
                "<leader>{",
                function() require("harpoon"):list():select(3) end,
                desc = "Harpoon to buffer 3",
            },
            {
                "<leader>(",
                function() require("harpoon"):list():select(3) end,
                desc = "Harpoon to buffer 4",
            },
            {
                "<leader>&",
                function() require("harpoon"):list():select(3) end,
                desc = "Harpoon to buffer 5",
            },
        },
    },
}

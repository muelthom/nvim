return {
    "Exafunction/codeium.nvim",
    enabled = false, -- Disabled by default
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    -- Codeium is configured to not only show virtual text upon request.
    config = function()
        require("codeium").setup({
            -- Disable cmp source if using virtual text only.
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                manual = true, -- Never show completions automatically
                -- Priority of the virtual text. This usually ensures that the completions appear on top of
                -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
                -- desired.
                virtual_text_priority = 65535,
                -- Set to false to disable all key bindings for managing completions.
                map_keys = true,
                -- The key to press when hitting the accept keybinding but no completion is showing.
                -- Defaults to \t normally or <c-n> when a popup is showing.
                accept_fallback = nil,
                -- Key bindings for managing completions in virtual text mode.
                key_bindings = {
                    accept = "<Tab>",
                    accept_word = false,
                    accept_line = false,
                    clear = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                }
            }
        })
    end,
    keys = {
        {
            "<C-s>",
            mode = { "n", "i" },
            function() require('codeium.virtual_text').cycle_or_complete() end,
            desc = "Request a code _s_suggestion."
        },
    },
}

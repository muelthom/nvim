return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Mason for managing external tools
        "williamboman/mason.nvim",
        -- Mason integration for nvim-dap
        "jay-babu/mason-nvim-dap.nvim",
        {
            -- Optional: UI for nvim-dap
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            config = true
        },
    },
    keys = {
        { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                   mode = { "n", "v" } },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
        { "<F5>",       function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<F6>",       function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<F7>",       function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" }
    },
    config = function()
        local mason_dap = require("mason-nvim-dap")

        -- Setup mason-nvim-dap to ensure DAP adapters are installed
        mason_dap.setup({
            ensure_installed = {
                "debugpy",
                "devel"
            },
            automatic_installation = true,

            handlers = {
                function(config)
                    -- All sources with no handler get passed here

                    -- Keep original functionality
                    require("mason-nvim-dap").default_setup(config)
                end,

                python = function(config)
                    config.adapters = {
                        type = "executable",
                        command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
                    }
                    require("mason-nvim-dap").default_setup(config) -- don't forget this!
                end,
            },
        })
    end,
}

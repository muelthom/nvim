return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<F3>",
            function()
                local conform = require("conform")
                conform.format({ async = true })

                local formatters = conform.list_formatters_for_buffer()
                if formatters and #formatters > 0 then
                    local remainingFormatters = { unpack(formatters, 2) }
                    local formatterString = formatters[1]
                    if #remainingFormatters > 0 then
                        formatterString = formatterString .. " (" .. table.concat(remainingFormatters, ", ") .. ")"
                    end
                    vim.print("[Conform] Formatted buffer using: " .. formatterString)
                else
                    vim.print("[Conform] No formatters available for this buffer.")
                end
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format", "isort", "black" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            lua = { "stylua" },
            shfmt = {
                prepend_args = { "-i", "2" },
            },
            -- Determine formatter dynamically
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

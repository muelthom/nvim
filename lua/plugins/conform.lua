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
            mode = { "n", "i" },
            desc = "Format buffer",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            go = { "gofmt" },
            json = { "jq" },
            lua = { "stylua" },
            python = { "ruff_organize_imports", "ruff_format" },
            yaml = { "yamlfmt" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = false,
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
            yamlfmt = {},
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

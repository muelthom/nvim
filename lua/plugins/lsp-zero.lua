return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually.
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        }
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/nvim-cmp",
                "lukas-reineke/cmp-under-comparator"
            },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                enabled = function()
                    -- Disable completion in comments.
                    local context = require "cmp.config.context"
                    -- Keep command mode completion enabled when cursor is in a comment.
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end,
                sources = {
                    -- Adjust the priority by changing the order of the items in the list.
                    {
                        name = "nvim_lsp",
                        keyword_length = 3
                    },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    {
                        name = "luasnip",
                        keyword_length = 3
                    },
                    {
                        name = "buffer",
                        keyword_length = 3,
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                    },
                    { name = "codeium" },
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                    },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                formatting = lsp_zero.cmp_format({ details = true }), -- Show source name in completion menu
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                }),
                -- Preselect first item (in the completion list).
                preselect = "item",
                completion = { completeopt = "menu,menuone,noinsert" },
                experimental = {
                    ghost_text = true -- Shows a preview of the auto-completed text in-place
                }
            })
        end
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig({
                sign_text = true, -- Enable or disable the diagnostic signs
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            })

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ruff",
                },
                handlers = {
                    lsp_zero.default_setup,

                    -- Language server configurations
                    -- https://lsp-zero.netlify.app/docs/language-server-configuration.html#configure-language-servers
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,

                    -- pylsp = function()
                    --     require("lspconfig").pylsp.setup({})
                    -- end,

                    ruff = function()
                        require("lspconfig").ruff.setup({})
                    end,
                }
            })

            local allow_format = function(servers)
                return function(client) return vim.tbl_contains(servers, client.name) end
            end

            lsp_zero.on_attach(function(client, bufnr)
                -- See :help lsp-zero-keybindings
                lsp_zero.default_keymaps({ buffer = bufnr })

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
                vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end)
                vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end)
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
                vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end)
                vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end)
                vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end)
            end)

            vim.diagnostic.config({
                float = {
                    border = "rounded",
                    focusable = true,
                    header = "",
                    prefix = "",
                    source = true,
                    style = "minimal",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
            })
        end
    }
}

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
                "hrsh7th/nvim-cmp"
            },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
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
                    { name = "nvim_lsp" }, -- Show completions send by the language server
                    { name = "nvim_lsp_signature_help" },
                    { name = "codeium" },
                    { name = "path" },     -- Gives completions based on the file system
                    {
                        name = "luasnip",  -- Shows custom snippets in the suggestions
                        keyword_length = 2
                    },
                    {
                        name = "buffer",    -- Provide suggestions based on the current file
                        keyword_length = 4, -- The number of characters to be typed to trigger auto-completion
                        -- Avoid accidentally running this source on big files.
                        get_bufnrs = function()
                            local buf = vim.api.nvim_get_current_buf()
                            local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                            if byte_size > 1024 * 1024 then -- 1 Megabyte max
                                return {}
                            end
                            return { buf }
                        end
                    }
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
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig({
                sign_text = true, -- Enable or disable the diagnostic signs
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            })

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                }
            })

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })

                vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end)
                vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end)
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
                vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end)
                vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end)
                vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end)

                -- Format code using a keybinding
                local opts = { buffer = bufnr }
                vim.keymap.set({ "n", "x" }, "gq", function()
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end, opts)
            end)

            -- Language server configurations
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            })
            require('lspconfig').pylsp.setup({})
        end
    }
}

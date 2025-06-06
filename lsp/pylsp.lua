return {
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
    single_file_support = true,
    -- Config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pylsp
    settings = {
        pylsp = {
            plugins = {
                configurationSources = { "pycodestyle", "pylint" },
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 88,
                },
                pylint = { enabled = true },
            },
        },
    },
}

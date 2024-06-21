return {
    vim.keymap.set("n", "<leader>ff", "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>"),
    vim.keymap.set("n", "<leader>fs", "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>"),
    vim.keymap.set("n", "ga", "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>"),
    vim.keymap.set("n", "gi", "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>"),
    vim.keymap.set("n", "gl", "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>"),
    vim.keymap.set("n", "go", "<Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>"),
    vim.keymap.set("n", "gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>"),
    vim.keymap.set("n", "gs", "<Cmd>call VSCodeNotify('editor.action.triggerParameterHints')<CR>"),
}

_G.invert_word = function()
    -- Mapping of words to their negated counterparts
    local invert_map = {
        ["true"] = "false",
        ["after"] = "before",
        ["start"] = "end",
        ["left"] = "right",
        ["first"] = "last",
        ["private"] = "public",
        ["PRIVATE"] = "PUBLIC"
    }

    -- Inverted mapping to support both directions
    for k, v in pairs(invert_map) do
        invert_map[v] = k
    end

    -- Function to capitalize the first letter of a word
    local function capitalize(word)
        return word:sub(1, 1):upper() .. word:sub(2):lower()
    end

    -- Get the word under the cursor
    local word = vim.fn.expand("<cword>")
    local lower_word = word:lower()

    -- Check if the lowercase word is in the invert_map
    if invert_map[lower_word] then
        -- Get the replacement word
        local replacement = invert_map[lower_word]
        -- Preserve the capitalization if the original word is capitalized
        if word:match("^[A-Z]") then
            replacement = capitalize(replacement)
        end

        -- Get the current cursor position
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local row, col = cursor_pos[1], cursor_pos[2]

        -- Replace the word under the cursor
        vim.cmd("normal! ciw" .. replacement)

        -- Restore the cursor position
        vim.api.nvim_win_set_cursor(0, { row, col })
    end
end


-- Automatically add opened buffers to Harpoon.
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)

        -- Ignore unnamed buffers, directories, and cwd (".")
        if bufname == "" or bufname == "." or vim.fn.isdirectory(bufname) == 1 then
            return
        end

        local harpoon = require("harpoon")
        local harpoon_list = harpoon:list()

        local exists = false
        for _, mark in ipairs(harpoon_list.items) do
            if mark.value == bufname then
                exists = true
                break
            end
        end

        if not exists and #harpoon_list.items < 5 then
            harpoon:list():add()
        end
    end,
})

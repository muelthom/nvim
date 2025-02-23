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
        vim.api.nvim_win_set_cursor(0, {row, col})
    end
end


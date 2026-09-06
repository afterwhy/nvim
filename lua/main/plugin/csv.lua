vim.api.nvim_create_autocmd("FileType", {
    pattern = { "csv", "tsv" },
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/mechatroner/rainbow_csv" },
        })

        local function rbcsv_map(buf, key, cmd)
            vim.keymap.set("n", key, function()
                if vim.b.rbcsv == 1 then
                    return ":" .. cmd .. "<CR>"
                else
                    return key
                end
            end, { buffer = buf, expr = true, silent = true })
        end

        local buf = vim.api.nvim_get_current_buf()
        rbcsv_map(buf, "<C-Left>", "RainbowCellGoLeft")
        rbcsv_map(buf, "<C-Right>", "RainbowCellGoRight")
        rbcsv_map(buf, "<C-Up>", "RainbowCellGoUp")
        rbcsv_map(buf, "<C-Down>", "RainbowCellGoDown")
    end,
})

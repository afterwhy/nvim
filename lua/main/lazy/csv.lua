return {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" }, -- грузим только для нужных файлов
    config = function()
        local function rbcsv_map(buf, key, cmd)
            vim.keymap.set("n", key, function()
                if vim.b.rbcsv == 1 then
                    return ":" .. cmd .. "<CR>"
                else
                    return key
                end
            end, { buffer = buf, expr = true, silent = true })
        end

        -- автокоманда, когда rainbow_csv активируется
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "csv", "tsv" },
            callback = function(args)
                local buf = args.buf

                rbcsv_map(buf, "<C-Left>", "RainbowCellGoLeft")
                rbcsv_map(buf, "<C-Right>", "RainbowCellGoRight")
                rbcsv_map(buf, "<C-Up>", "RainbowCellGoUp")
                rbcsv_map(buf, "<C-Down>", "RainbowCellGoDown")
            end,
        })
    end,
}


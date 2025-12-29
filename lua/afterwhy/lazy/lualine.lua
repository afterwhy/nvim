local function in_git_repo()
    -- только для обычных файлов
    if vim.bo.buftype ~= "" then
        return false
    end

    -- ищем git относительно файла
    local path = vim.fn.expand("%:p:h")
    if path == "" then
        return false
    end

    return vim.fn.finddir(".git", path .. ";") ~= ""
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require("lualine").setup({
            options = {
                icons_enabled = false,
                component_separators = "",
                section_separators = "",
                globalstatus = true,
                disabled_filetypes = {
                    statusline = {
                        "terminal",
                        "toggleterm",
                        "lazy",
                        "lazygit",
                        "netrw",
                        "NvimTree",
                    },
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "branch", cond = in_git_repo },
                },
                lualine_c = {
                    { "filename", path = 1 },
                },
                lualine_z = { "location" },
            },
        })
    end
}

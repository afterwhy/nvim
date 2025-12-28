return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            disable_netrw = false,
            --hijack_cursor = false,
            hijack_netrw = false,
            -- hijack_directories = { enable = false, auto_open = false },
            -- on_attach = "disable-default",

            view = {
                width = 30,
                side = "left",
            },

            update_focused_file = {
                enable = true,
            },
        })
    end,
}

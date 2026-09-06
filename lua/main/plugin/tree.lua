vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = false,

    view = {
        width = 30,
        side = "left",
    },

    update_focused_file = {
        enable = true,
    },
})

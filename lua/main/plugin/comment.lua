vim.pack.add({
    {
        src = "https://github.com/numToStr/Comment.nvim",
        load = function()
            require("Comment").setup()
        end,
    },
})

-- require("Comment").setup({})

vim.pack.add({
    { src = "https://github.com/tpope/vim-fugitive" },
})

vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" }, -- lazygit dependency for floating window
    { src = "https://github.com/kdheepak/lazygit.nvim" },
}, { load = false, })

local keymap = require("main.util.cyrillic_keymap")

-- vim-fugitive
keymap("n", "<leader>gtl", ":Git log<CR>", { desc = "Git log" })
keymap("n", "<leader>gtlc", ":Git log --oneline --decorate --graph<CR>", { desc = "Git compact log" })
keymap("n", "<leader>gtd", ":Gdiffsplit<CR>", { desc = "Git diff" })
keymap("n", "<leader>gtdv", ":Gvdiffsplit<CR>", { desc = "Git diff" })
keymap("n", "<leader>gtb", ":Git blame<CR>", { desc = "Git blame" })

-- lazygit
keymap("n", "<leader>lg", function()
    vim.cmd.packadd("plenary.nvim")
    vim.cmd.packadd("lazygit.nvim")
    vim.cmd("LazyGit")
end, {
    desc = "LazyGit",
})

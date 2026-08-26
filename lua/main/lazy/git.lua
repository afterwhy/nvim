return {
    { 
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        } 
    },
    { 
        "tpope/vim-fugitive",

        config = function()
            vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
            vim.keymap.set("n", "<leader>glc", ":Git log --oneline --decorate --graph<CR>", { desc = "Git compact log" })
            vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
            vim.keymap.set("n", "<leader>gdv", ":Gvdiffsplit<CR>", { desc = "Git diff" })
            vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
            vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
        end
    }
}

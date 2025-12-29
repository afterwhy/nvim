return {
    "nvim-telescope/telescope.nvim",

    tag = "v0.2.0",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local actions = require("telescope.actions.layout")
        require('telescope').setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    preview_width = 0.5,
                },
                preview = {
                    hide_on_startup = false,
                },
                mappings = {
                    i = { ["<C-p>"] = actions.toggle_preview },
                    n = { ["<C-p>"] = actions.toggle_preview },
                },
            },
        })

        local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<M-f>', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
    end
}

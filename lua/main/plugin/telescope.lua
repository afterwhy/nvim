local keymap = require("main.util.cyrillic_keymap")

vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.1" },
}, { load = true })

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
            i = { ["<C-p>"] = actions.toggle_preview, ["<C-з>"] = actions.toggle_preview },
            n = { ["<C-p>"] = actions.toggle_preview, ["<C-з>"] = actions.toggle_preview },
        },
    },
})

local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<M-f>', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keymap('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
keymap("n", "<leader>?", builtin.keymaps, { desc = "Show keymaps" })

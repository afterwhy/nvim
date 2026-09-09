local cmd_file_manager = vim.cmd.Oil

vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

local keymap = require("main.util.cyrillic_keymap")
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

require("oil").setup()

keymap("n", "<M-e>", cmd_file_manager)
keymap("n", "<M-у>", cmd_file_manager)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")


----------------------------------------------
-- Setup nvimtree so it would automatically --
-- close once last buffer is closed,        --
-- or once netrw entered.                   --
----------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    local ok, api = pcall(require, "nvim-tree.api")
    if ok and api.tree.is_visible() then
      api.tree.close()
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("silent! quit")
    end
  end,
})

-- nvimtree setup ends here --

vim.g.mapleader = " "

-- disable standard navigation
function DisableArrowNavigation()
    local map = vim.keymap.set

    local modes = {'n', 'i', 'v'}
    local keys = {'<Up>', '<Down>', '<Left>', '<Right>', '<Home>', '<End>', '<PageUp>', '<PageDown>'}

    for _, mode in ipairs(modes) do
        for _, key in ipairs(keys) do
            map(mode, key, '<Nop>', { noremap = true, silent = true })
        end
    end
end
DisableArrowNavigation()

local keymap = require("main.util.cyrillic_keymap")

keymap("n", "<leader>o", ":update<CR>:source<CR>")
keymap("n", "<leader>w", ":write<CR>")

-- move lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- replaces highligted woed and keeps original buffer
keymap("x", "<leader>p", [["_dP]])

-- copy to system clipboard
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

-- delete to void register
keymap({ "n", "v" }, "<leader>d", "\"_d")

-- quick replace current word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- splits
keymap({'n', 't'}, '<C-h>', '<C-w>h')
keymap({'n', 't'}, '<C-j>', '<C-w>j')
keymap({'n', 't'}, '<C-k>', '<C-w>k')
keymap({'n', 't'}, '<C-l>', '<C-w>l')
keymap('n', '<M-r>', vim.cmd.vsplit)
keymap('n', '<M-d>', vim.cmd.split)
keymap('n', '<M-q>', vim.cmd.q)

-- formatting
keymap("n", "<leader>=", "gggqG", { buffer = true })

local cyrillic_aware_keymap = require("new.cyrillic_keymap")

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

cyrillic_aware_keymap("n", "<M-e>", vim.cmd.Ex)
cyrillic_aware_keymap("n", "<leader>e", ":NvimTreeToggle<CR>")

-- move lines up and down
cyrillic_aware_keymap("v", "J", ":m '>+1<CR>gv=gv")
cyrillic_aware_keymap("v", "K", ":m '<-2<CR>gv=gv")

-- replaces highligted woed and keeps original buffer
cyrillic_aware_keymap("x", "<leader>p", [["_dP]])

-- copy to system clipboard
cyrillic_aware_keymap({ "n", "v" }, "<leader>y", [["+y]])
cyrillic_aware_keymap("n", "<leader>Y", [["+Y]])

-- delete to void register
cyrillic_aware_keymap({ "n", "v" }, "<leader>d", "\"_d")

-- quick replace current word
cyrillic_aware_keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
cyrillic_aware_keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- splits
cyrillic_aware_keymap({'n', 't'}, '<C-h>', '<C-w>h')
cyrillic_aware_keymap({'n', 't'}, '<C-j>', '<C-w>j')
cyrillic_aware_keymap({'n', 't'}, '<C-k>', '<C-w>k')
cyrillic_aware_keymap({'n', 't'}, '<C-l>', '<C-w>l')
cyrillic_aware_keymap('n', '<M-r>', vim.cmd.vsplit)
cyrillic_aware_keymap('n', '<M-d>', vim.cmd.split)
cyrillic_aware_keymap('n', '<M-q>', vim.cmd.q)

-- formatting
cyrillic_aware_keymap("n", "<leader>=", "gggqG", { buffer = true })

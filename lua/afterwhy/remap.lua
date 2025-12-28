vim.g.mapleader = " "
vim.keymap.set("n", "<M-e>", vim.cmd.Ex)
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- replaces highligted woed and keeps original buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- quick replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- splits
vim.keymap.set({'n', 't'}, '<C-h>', '<C-w>h')
vim.keymap.set({'n', 't'}, '<C-j>', '<C-w>j')
vim.keymap.set({'n', 't'}, '<C-k>', '<C-w>k')
vim.keymap.set({'n', 't'}, '<C-l>', '<C-w>l')
vim.keymap.set('n', '<M-r>', vim.cmd.vsplit)
vim.keymap.set('n', '<M-d>', vim.cmd.split)
vim.keymap.set('n', '<M-q>', vim.cmd.q)

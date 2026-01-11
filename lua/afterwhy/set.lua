--netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "name"
vim.g.netrw_sizestyle = "H"
vim.g.netrw_sort_sequence = [[^\d*,^\~*,*,]]

-- terminal
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -Command " ..
    "[Console]::OutputEncoding=[Text.UTF8Encoding]::UTF8; " ..
    "$PSStyle.OutputRendering='PlainText';"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

-- haskel autoformat
vim.api.nvim_create_autocmd("FileType", {
  pattern = "haskell",
  callback = function()
    if vim.fn.executable("fourmolu") == 1 then
        vim.opt_local.formatprg = "fourmolu --stdin-input-file %"
    end
  end,
})

--remove tildas
vim.opt.fillchars = vim.opt.fillchars + "eob: "

--vim.opt.guicursor = " "

vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

--vim.opt.swapfile = false
--vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

--vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.opt.splitright = true
vim.opt.splitbelow = true

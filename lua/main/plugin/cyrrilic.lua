vim.pack.add({
    { src = "https://github.com/nativerv/cyrillic.nvim" },
})
require("cyrillic").setup({ no_cyrillic_abbrev = false })
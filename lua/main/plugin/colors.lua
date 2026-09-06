vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
}, { load = true })

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
})

function SetColoring(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColoring()

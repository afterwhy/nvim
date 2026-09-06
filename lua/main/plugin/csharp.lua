local keymap = require("main.util.cyrillic_keymap")

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cs" },
    once = true,
    callback = function()
        vim.pack.add {
            { src = "https://github.com/seblyng/roslyn.nvim" }
        }

        vim.lsp.config("roslyn", {})
        vim.lsp.enable({ "roslyn" })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        keymap("n", "gT", function() require("roslyn.lsp").go_to_target_typedef() end, { desc = "LSP: Go to Target Type Definition" })

        -- Refresh Code Lens manually (references/implementations headers above methods)
        keymap("n", "<leader>cl", vim.lsp.codelens.run, { desc = "LSP: Run CodeLens Action" })
    end,
})

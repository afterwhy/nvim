local keymap = require("main.util.cyrillic_keymap")
local function map(mode, lhs, rhs, desc)
    keymap(mode, lhs, rhs, { desc = "LSP: " .. desc })
end

vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' }, -- LSP support itself
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    once = true,
    callback = function()
        vim.pack.add {
            { src = "https://github.com/folke/lazydev.nvim" }, -- Neovim-plugin development plugin. Enbales to get rid of warnings in lua configs
        }
        require("lazydev").setup()
        vim.lsp.enable({ "lua_ls" })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
            autotrigger = true,
        })

        vim.opt.completeopt = {
            "menu",
            "menuone",
            "noselect",
            "fuzzy",
            "popup",
        }


        map("i", "<C-Space>", function() vim.lsp.completion.get() end, "Completion")
        map("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "<C-b>", vim.lsp.buf.definition, "Go to definition")
        map("n", "<leader>gr", vim.lsp.buf.references, "Find references")
        map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "<leader>sh", function() vim.diagnostic.open_float() end, "Show diagnostic hint")
        map("n", "<leader>sd", vim.lsp.buf.hover, "Show documentation")
        map("i", "<Down>", "<C-n>", "Next completion item")
        map("i", "<Up>", "<C-p>", "Prev completion item")

        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Smart Rename")
        map("n", "<leader>fb", function() vim.lsp.buf.format({ async = true }) end, "Format Document")

        -----------------------------------------------------------------
        -- Diagnostic Navigation (Neovim 0.10+)
        ------------------------------------------------------------------
        -- Cycle through ALL diagnostics
        map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
        map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous Diagnostic")

        -- Cycle ONLY through Errors
        map("n", "]e", function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
        end, "Next Error")

        map("n", "[e", function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
        end, "Previous Error")

        -- Cycle ONLY through Warnings & Hints
        map("n", "]w", function()
            vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.WARN }, float = true })
        end, "Next Warning/Hint")

        map("n", "[w", function()
            vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.WARN }, float = true })
        end, "Previous Warning/Hint")

        -- Open diagnostic float popup manually
        map("n", "<leader>de", vim.diagnostic.open_float, "Show Line Diagnostics")

        -- Populate quickfix list
        map("n", "<leader>dq", vim.diagnostic.setqflist, "Project Diagnostics to Quickfix")
    end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

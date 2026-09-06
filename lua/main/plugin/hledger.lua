vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.journal", "*.hledger" },
    callback = function()
        vim.bo.filetype = "hledger"
        vim.bo.commentstring = "# %s"
    end,
})

local keymap = require("main.util.cyrillic_keymap")

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "hledger" },
    once = true,
    callback = function()
        vim.pack.add {
            { src = "https://github.com/ptimoney/hledger-nvim" },
        }
        vim.lsp.config("hledger_lsp", {
            filetypes = { "hledger" },

            settings = {
                hledgerLanguageServer = {
                    formatting = {
                        decimalAlignColumn = 71,
                    }
                },
            },
        })
        require("hledger").setup({})
        vim.lsp.enable({ "hledger_lsp" })

        -- -- Глобальное выравнивание всего файла по запятой
        vim.keymap.set("n", "<leader>=", function()
            local view = vim.fn.winsaveview()
            vim.lsp.buf.format({ async = false, })
            vim.fn.winrestview(view)
        end, { buffer = true, desc = "Format hledger", })

        vim.keymap.set('n', ']]', [[/^[0-9]\{4\}/<CR>:noh<CR>]], { buffer = true, silent = true, desc = "Hledger: Next transaction" })
        vim.keymap.set('n', '[[', [[?^[0-9]\{4\}<CR>:noh<CR>]], { buffer = true, silent = true, desc = "Hledger: Previous transaction" })
        keymap('n', '<leader>lw', function()
            local save = vim.fn.winsaveview()
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.winrestview(save)
            print("Trailing whitespace cleared")
        end, { buffer = true, silent = true, desc = "Hledger: Clear trailing whitespace" })

        -- Clean witespace on buffer save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = 0,
            callback = function()
                local view = vim.fn.winsaveview()
                vim.cmd([[%s/\s\+$//e]])
                vim.fn.winrestview(view)
            end,
        })
    end
})

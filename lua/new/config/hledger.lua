local autocmd_group = vim.api.nvim_create_augroup("LedgerMappings", { clear = true })

local function format_hledger()
    local view = vim.fn.winsaveview()
    vim.cmd('1,$LedgerAlign')
    vim.fn.winrestview(view)
    print("Ledger: Full file aligned by '" .. vim.g.ledger_decimal_sep .. "'")
end

local function trim_trailing_whitespaces()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
    print("Trailing whitespace cleared")
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "ledger",
    group = autocmd_group,
    callback = function()
        local opts = { buffer = true, silent = true }

        vim.keymap.set('n', '<leader>la', format_hledger, { buffer = true, desc = "Ledger: Align entire file" })
        vim.keymap.set('n', '<leader>дф', format_hledger, { buffer = true, desc = "Ledger: Align entire file" })

        vim.keymap.set('v', '<leader>la', ':LedgerAlign<CR>', opts)
        vim.keymap.set('v', '<leader>дф', ':LedgerAlign<CR>', opts)

        vim.keymap.set('n', '<leader>lw', trim_trailing_whitespaces, { buffer = true, desc = "Ledger: Clear trailing whitespace" })
        vim.keymap.set('n', '<leader>дц', trim_trailing_whitespaces, { buffer = true, desc = "Ledger: Clear trailing whitespace" })

        vim.keymap.set('n', '<leader>lt', ':call ledger#transaction_state_toggle(line("."), " *")<CR>', opts)
        vim.keymap.set('n', '<leader>де', ':call ledger#transaction_state_toggle(line("."), " *")<CR>', opts)

        vim.opt_local.omnifunc = 'ledger#complete'

        vim.keymap.set('n', ']]', [[/^[0-9]\{4\}/<CR>:noh<CR>]], opts)
        vim.keymap.set('n', '[[', [[?^[0-9]\{4\}<CR>:noh<CR>]], opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = 0,
            callback = function()
                local view = vim.fn.winsaveview()
                vim.cmd([[%s/\s\+$//e]])
                vim.fn.winrestview(view)
            end,
        })
    end,
})

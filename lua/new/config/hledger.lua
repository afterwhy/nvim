local cyrillic_aware_keymap = require("new.cyrillic_keymap")
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

        cyrillic_aware_keymap('n', '<leader>la', format_hledger, { buffer = true, desc = "Ledger: Align entire file" })
        cyrillic_aware_keymap('v', '<leader>la', ':LedgerAlign<CR>', opts)
        cyrillic_aware_keymap('n', '<leader>lw', trim_trailing_whitespaces, { buffer = true, desc = "Ledger: Clear trailing whitespace" })
        cyrillic_aware_keymap('n', '<leader>lt', ':call ledger#transaction_state_toggle(line("."), " *")<CR>', opts)

        vim.opt_local.omnifunc = 'ledger#complete'

        cyrillic_aware_keymap('n', ']]', [[/^[0-9]\{4\}/<CR>:noh<CR>]], opts)
        cyrillic_aware_keymap('n', '[[', [[?^[0-9]\{4\}<CR>:noh<CR>]], opts)

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

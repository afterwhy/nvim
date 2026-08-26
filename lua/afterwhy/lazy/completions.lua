return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "afterwhy/cmp-hledger", branch="main" },
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            sources = cmp.config.sources({
                { name = "hledger", filetype = "ledger" },
            }),
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
            }),
            performance = {
                max_view_entries = 10,  -- max visible in popup at once
            },
        })
    end,
}

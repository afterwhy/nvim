require("new.set")
require("new.remap")

vim.g.ledger_bin = 'hledger'
vim.g.ledger_decimal_sep = ','
vim.g.ledger_align_at_dot = 1
vim.g.ledger_align_at = 72
vim.g.ledger_date_format = '%Y-%m-%d'
vim.g.ledger_fuzzy_account_completion = 1

----------------------------------------------
-- Setup nvimtree so it would automatically --
-- close once last buffer is closed,        --
-- or once netrw entered.                   --
----------------------------------------------

vim.api.nvim_create_user_command("Ex", function(opts)
  local ok, api = pcall(require, "nvim-tree.api")
  if ok and api.tree.is_visible() then
    api.tree.close()
  end

  vim.cmd("Explore " .. (opts.args or ""))
end, { nargs = "?" })


vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 then
            local bufname = vim.api.nvim_buf_get_name(0)
            if bufname:match("NvimTree_") then
                vim.cmd("silent! quit")
            end
        end
    end,
})
-- nvimtree setup ends here --

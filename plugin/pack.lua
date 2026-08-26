-- All vim.pack.add() declarations for the new config
-- Plugins are ordered by dependency: independent plugins first, then dependents

-- Eager plugins (always loaded)
vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin", version = vim.version.range("*") },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua", version = vim.version.range("*") },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/numToStr/Comment.nvim" },
    { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("^3.0.0") },
    { src = "https://github.com/nativerv/cyrillic.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim", version = vim.version.range("*") },
}, { load = true })

-- Config for eager plugins (must be required after vim.pack.add)
require("new.config.colors")
require("new.config.lualine")
require("new.config.tree")
require("new.config.toggleterm")

-- vim-fugitive keymaps
vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
vim.keymap.set("n", "<leader>glc", ":Git log --oneline --decorate --graph<CR>", { desc = "Git compact log" })
vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gdv", ":Gvdiffsplit<CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })

-- nvim-surround and cyrillic.nvim default setup
require("nvim-surround").setup({})
require("cyrillic").setup({ no_cyrillic_abbrev = false })

-- Comment.nvim default setup
require("Comment").setup({})

----------------------------------------------------------------
-- Lazy-loaded plugins (load = false, triggered by autocommands)
----------------------------------------------------------------

-- Telescope: load on keymaps
local function load_telescope()
    vim.pack.add({
        { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("v0.2.0") },
    }, {
        load = function(data)
            vim.cmd.packadd(data.spec.name)
            require("new.config.telescope")
        end,
    })
end

for _, key in ipairs({ "<leader>ff", "<leader>fg", "<M-f>", "<C-p>" }) do
    vim.keymap.set("n", key, function()
        load_telescope()
        local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
        vim.api.nvim_feedkeys(keys, "mit", false)
    end, { desc = "Telescope" })
end

-- nvim-cmp: load on InsertEnter
vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/hrsh7th/nvim-cmp" },
            { src = "https://github.com/afterwhy/cmp-hledger", version = vim.version.range("main") },
        }, {
            load = function(data)
                vim.cmd.packadd(data.spec.name)
                if data.spec.name == "nvim-cmp" then
                    require("new.config.completions")
                end
            end,
        })
    end,
})

-- Treesitter: load on BufRead/BufNewFile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = vim.version.range("*") },
        }, {
            load = function(data)
                vim.cmd.packadd(data.spec.name)
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "lua",
                        "vim",
                        "query",
                        "bash",
                        "json",
                        "yaml",
                        "toml",
                        "markdown",
                        "markdown_inline",
                        "ledger",
                        "java",
                        "haskell",
                        "c",
                        "cpp",
                        "python",
                        "javascript",
                        "typescript",
                        "html",
                        "css",
                    },
                    auto_install = true,
                    indent = { enable = true },
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = { "markdown" },
                    },
                })
                vim.cmd.TSUpdate()
            end,
        })
    end,
})

-- LazyGit: load on command
local function load_lazygit()
    vim.pack.add({
        { src = "https://github.com/kdheepak/lazygit.nvim" },
    }, { load = true })
end

vim.api.nvim_create_user_command("LazyGit", function()
    load_lazygit()
    vim.cmd.LazyGit()
end, {})

vim.keymap.set("n", "<leader>lg", function()
    load_lazygit()
    vim.cmd.LazyGit()
end, { desc = "LazyGit" })

-- rainbow_csv: load on FileType csv/tsv
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "csv", "tsv" },
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/mechatroner/rainbow_csv" },
        }, { load = true })

        local function rbcsv_map(buf, key, cmd)
            vim.keymap.set("n", key, function()
                if vim.b.rbcsv == 1 then
                    return ":" .. cmd .. "<CR>"
                else
                    return key
                end
            end, { buffer = buf, expr = true, silent = true })
        end

        local buf = vim.api.nvim_get_current_buf()
        rbcsv_map(buf, "<C-Left>", "RainbowCellGoLeft")
        rbcsv_map(buf, "<C-Right>", "RainbowCellGoRight")
        rbcsv_map(buf, "<C-Up>", "RainbowCellGoUp")
        rbcsv_map(buf, "<C-Down>", "RainbowCellGoDown")
    end,
})

-- vim-ledger: load on FileType ledger/journal
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.journal",
    callback = function()
        vim.bo.filetype = "ledger"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "ledger", "journal" },
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/ledger/vim-ledger" },
        }, {
            load = function(data)
                vim.cmd.packadd(data.spec.name)
                require("new.config.hledger")
            end,
        })
    end,
})

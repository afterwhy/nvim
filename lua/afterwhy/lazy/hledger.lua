return {
    -- {
    --     "dahelb/hledger.nvim"
    -- },
    {
        'ledger/vim-ledger',
        -- Активируем плагин сразу при открытии этих файлов
        ft = { 'ledger', 'journal' },

        init = function()
            -- Настройки ДО загрузки
            vim.g.ledger_bin = 'hledger'
            vim.g.ledger_decimal_sep = ','
            vim.g.ledger_align_at_dot = 1
            vim.g.ledger_align_at = 52
            vim.g.ledger_date_format = '%Y-%m-%d'
            vim.g.ledger_fuzzy_account_completion = 1

            -- Принудительно ставим тип файла для .journal
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = "*.journal",
                callback = function()
                    vim.bo.filetype = "ledger"
                end,
            })
        end,

        config = function()
            local autocmd_group = vim.api.nvim_create_augroup("LedgerMappings", { clear = true })


            vim.api.nvim_create_autocmd("FileType", {
                pattern = "ledger",
                group = autocmd_group,
                callback = function()
                    local opts = { buffer = true, silent = true }

                    -- Глобальное выравнивание всего файла по запятой
                    vim.keymap.set('n', '<leader>la', function()
                        -- Сохраняем состояние экрана (позицию курсора и прокрутку)
                        local view = vim.fn.winsaveview()

                        -- Выполняем LedgerAlign для всего диапазона (от 1 до последней строки $)
                        -- Использование <cmd>...<CR> быстрее и не засоряет командную строку
                        vim.cmd('1,$LedgerAlign')

                        -- Возвращаем курсор на место
                        vim.fn.winrestview(view)

                        print("Ledger: Full file aligned by '" .. vim.g.ledger_decimal_sep .. "'")
                    end, { buffer = true, desc = "Ledger: Align entire file" })

                    -- возможность выравнивания только выделенного
                    vim.keymap.set('v', '<leader>la', ':LedgerAlign<CR>', opts)
                    
                    -- Удаление пробелов во всем файле без перемещения курсора
                    vim.keymap.set('n', '<leader>lw', function()
                        local save = vim.fn.winsaveview()
                        vim.cmd([[%s/\s\+$//e]])
                        vim.fn.winrestview(save)
                        print("Trailing whitespace cleared")
                    end, { buffer = true, desc = "Ledger: Clear trailing whitespace" })

                    -- Новая транзакция (LUA-Native решение)
                    -- Просто вставляет текущую дату и переходит в режим вставки
                    vim.keymap.set('n', '<leader>le', function()
                        local date = os.date("%Y-%m-%d")
                        -- Вставляем строку с датой и два пробела, затем прыгаем в Insert mode
                        vim.api.nvim_put({ date .. " " }, "c", true, true)
                        vim.cmd("startinsert!")
                    end, { buffer = true, desc = "Ledger: Quick Entry" })

                    -- Переключение статуса (! / * / )
                    -- Единственная функция, которая вызывается именно так
                    vim.keymap.set('n', '<leader>lt', ':call ledger#transaction_state_toggle(line("."), " *")<CR>', opts)

                    -- Автодополнение
                    vim.opt_local.omnifunc = 'ledger#complete'

                    vim.keymap.set('n', ']]', [[/^[0-9]\{4\}/<CR>:noh<CR>]], opts)
                    vim.keymap.set('n', '[[', [[?^[0-9]\{4\}<CR>:noh<CR>]], opts)

                    -- ОЧИСТКА ПРОБЕЛОВ (При сохранении)
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
        end,
    },
        -- {
        --     "saghen/blink.cmp",
        --     version = "1.*",
        --     opts = {
        --         sources = {
        --             default = { "lsp", "path", "snippets", "buffer", "omni" },
        --         },
        --     },
        -- },
        -- {
        --     "mfussenegger/nvim-lint",
        --     config = function()
        --         require("lint").linters_by_ft = {
        --             hledger = {"hledger"},
        --         }
        --         require("lint").events = { "BufWritePost", "BufReadPost", "InsertLeave" }
        --     end
        --     -- opts = {
        --         --     events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        --         --     linters_by_ft = {
        --             --         hledger = { "hledger" },
        --             --     },
        --             --     linters = {},
        --             -- },
        --         },
        --         {
        --             "stevearc/conform.nvim",
        --             opts = {
        --                 formatters_by_ft = {
        --                     ledger = { "trim_newlines", "trim_whitespace" },
        --                 },
        --             },
        --         }
}

local function GetShell()
  local shell = vim.o.shell

  -- Приводим к нижнему регистру для надёжного сравнения
  local lower_shell = shell:lower()

   -- Если это CMD, пробуем заменить на pwsh / powershell
  if lower_shell:match("cmd") then
    if vim.fn.executable("pwsh") == 1 then
      return "pwsh -NoLogo"
    elseif vim.fn.executable("powershell") == 1 then
      return "powershell -NoLogo"
    else
      return shell  -- fallback на cmd
    end
  end

  -- Если PowerShell / pwsh → добавляем -NoLogo
  if lower_shell:match("powershell") or lower_shell:match("pwsh") then
    -- Проверяем, что -NoLogo ещё не стоит
    if not shell:match("%-NoLogo") then
      shell = shell .. " -NoLogo"
    end
  end

  return shell
end

return {
    'akinsho/toggleterm.nvim', 
    version = "*", 
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<c-\>]],
            shade_terminals = true,
            direction = "horizontal", -- также "vertical" или "float"
            shell = GetShell(),
        }
    end
}

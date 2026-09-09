-- terminal
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -Command " ..
    "[Console]::OutputEncoding=[Text.UTF8Encoding]::UTF8; " ..
    "$PSStyle.OutputRendering='PlainText';"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

vim.pack.add({
    { src = "https://github.com/akinsho/toggleterm.nvim" },
})

local function GetShell()
  local shell = vim.o.shell

  local lower_shell = shell:lower()

  if lower_shell:match("cmd") then
    if vim.fn.executable("pwsh") == 1 then
      return "pwsh -NoLogo"
    elseif vim.fn.executable("powershell") == 1 then
      return "powershell -NoLogo"
    else
      return shell
    end
  end

  if lower_shell:match("powershell") or lower_shell:match("pwsh") then
    if not shell:match("%-NoLogo") then
      shell = shell .. " -NoLogo"
    end
  end

  return shell
end

require("toggleterm").setup {
    size = 20,
    open_mapping = [[<c-\>]],
    shade_terminals = true,
    direction = "horizontal",
    shell = GetShell(),
}


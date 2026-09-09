-- loading all files inside plugins folder
local dir = vim.fn.stdpath("config") .. "/lua/main/plugin"

for name, type in vim.fs.dir(dir) do
    if type == "file" and name:match("%.lua$") and name ~= "_root.lua" then
    local module = name:gsub("%.lua$", "")
    require("main./plugin." .. module)
  end
end


-- require("main/plugin/colors")
-- require("main/plugin/files")
-- require("main/plugin/lualine")
-- require("main/plugin/terminal")
-- require("main/plugin/git")
-- require("main/plugin/telescope")
-- require("main/plugin/cyrrilic")
-- require("main/plugin/lsp")
-- require("main/plugin/csharp")
-- require("main/plugin/hledger")
-- require("main/plugin/csv")
-- require("main/plugin/comment")
-- require("main/plugin/surround")

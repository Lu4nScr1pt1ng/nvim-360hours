-- Better load time lua files
vim.loader.enable()


-- Require settings options
local ok, _ = pcall(require, "settings.options")
if not ok then
  print("[!] Error in loading settings option")
end


-- Require lazy nvim
local ok, _ = pcall(require, "plugins")
if not ok then
  print("[!] Error in loading init.lua in plugins")
end



local keymapspath = vim.fn.stdpath("config") .. "/lua/keymaps/init.lua"

if not vim.loop.fs_stat(keymapspath) then
  print("[!] Error in loading keymaps(Path doesn't exist)")
else
  vim.schedule(function()
    require("keymaps")
  end)
end



-- vim.cmd('colorscheme slate')
vim.cmd('colorscheme onedark_vivid')

vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "grey" })

vim.cmd([[
augroup FileTypeGroup
  au! BufRead,BufNewFile *.cls,*.trigger,*.apex set filetype=apex
augroup END
]])

vim.treesitter.language.register('java', 'apex')


local ok, mymod = pcall(require, 'module_with_error')
if not ok then
  print("Module had an error")
else 
	print("Another")
end




vim.keymap.set('n', '<Space>e', '<cmd> echo "Example 2"<cr>')

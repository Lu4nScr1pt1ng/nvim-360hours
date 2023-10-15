local map = vim.keymap.set


-- nvim/dap
map("n", "<leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { silent = true })
map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { silent = true })
map("n", "<leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { silent = true })
map("n", "<leader>d<space>", "<cmd>lua require'dap'.continue()<CR>", { silent = true })
map("n", "<leader>dbp", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
map("n", "<leader>dd", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
map("n", "<leader>de", "<cmd>lua require'dap'.terminate()<CR>", { silent = true })
map("n", "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { silent = true })

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Paste
map("n", "]p", "o<Esc>p", { desc = "Paste below" })
map("n", "]P", "O<Esc>p", { desc = "Paste above" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- Insert blank line
map("n", "]<Space>", "o<Esc>", { desc = "Insert blank line" })
map("n", "[<Space>", "O<Esc>", { desc = "Insert blank line" })

-- A couple Helix/Kakoune keymaps
map({ "n", "o", "x" }, "gl", "$", { desc = "Go to the last character in the line" })
map({ "n", "o", "x" }, "gh", "0", { desc = "Go to the first character in the line" })


-- tab switch
map({"n"}, "<Tab>", "<cmd>bn<cr>", { desc = "Switch buffer"})
map({"n"}, "<S-Tab>", "<cmd>bp<cr>", { desc = "Switch buffer"})

-- Super fun keymap wow!
map({ "n" }, "<C-C>", "ciw", { desc = "Change inside word" })

-- netwr

local open = false

local function close_explorer_buffers()
  if open then
    for i = 1, vim.fn.bufnr('$') do
      if vim.fn.getbufvar(i, '&filetype') == "netrw" then
        vim.cmd('silent bdelete ' .. i)
      end
    end
    open = false
  else
    vim.cmd('Lexplore')
    open = true
  end
end

map('n', '<Leader>nt', close_explorer_buffers, { silent = true })

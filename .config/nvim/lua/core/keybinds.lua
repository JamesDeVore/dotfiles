vim.g.mapleader = ' '
map("n", "<Space>", "<NOP>")

-- map("n", "<C-h>", "<C-w>h", opts)
-- map("n", "<C-j>", "<C-w>j", opts)
-- map("n", "<C-k>", "<C-w>k", opts)
-- map("n", "<C-l>", "<C-w>l", opts)

-- Buffers
map('n', '<space>qab', ":%bd|e#<CR>")
-- Diagnostics
map('n', '<space>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<space>q', vim.diagnostic.setloclist)
-- window management and resizing
map("v", "<", "<gv", { desc = "Decrease Indent" })
map("v", ">", ">gv")
map("n","<C-h>","<C-w>h")
map("n","<C-j>","<C-w>j")
map("n","<C-k>","<C-w>k")
map("n","<C-l>","<C-w>l")
-- Clipboard
map("n", "<Leader>y", '"+y')
map("v", "<Leader>y", '"+y')
-- Line moving
map("v", "<S-j>", ":m .+1<CR>gv=gv", { silent = true })
map("v", "<S-k>", ":m .-2<CR>gv=gv", { silent = true })
-- Tab management
map("n", "<tab>", ":bnext<CR>")
map("n", "<S-tab>", ":bprevious<CR>")
map("n", "<leader><tab>", ":tabnext<CR>")
map("n", "<leader><S-tab>", ":tabprevious<CR>")
--map("n", "<leader>tn", ":tabedit %<CR>")
--map("n", "<leader>td", ":tabclose<CR>")

map("n", "<M-h>", ":vertical resize +3<CR>", { noremap = true, silent = true })
map("n", "<M-j>", ":res -1<CR>", { noremap = true, silent = true })
map("n", "<M-k>", ":res +1<CR>", { noremap = true, silent = true })
map("n", "<M-l>", ":vertical resize -3<CR>", { noremap = true, silent = true })
map("n", "<leader>h", ":let @/ = ''<CR>")
map("x", "<leader>p", "\"_dP")
-- map("n", "<leader>qd", '"_d')
-- map("v", "<leader>qd", '"_')
map("n", "Q", "<NOP>", {})
-- debuggin-- easy acces to null info
vim.cmd('map <Leader>ln :NullLsInfo<CR>')
-- motions
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
-- Editor settings
map("i", "jj", "<Esc>", { desc = "Escape" })
vim.api.nvim_set_keymap("i", "<M-Enter>", "<Esc>o", { noremap = true, silent = true })
-- rename variables
map("n", "<leader>cr", "gd[{V%::s/<C-R>///gc<left><left><left>")
map("n", "<leader>cR", "gD:%s/<C-R>///gc<left><left><left>")

-- PHP doc maker
map("n", "<space>pdm", function()
  local filePath = vim.fn.expand('%:p:h')
  local fileName = vim.fn.expand('%:t')
  -- print(filePath)
  local docCommand = "php_doc_maker " .. filePath .. "/" .. fileName
  -- print(docCommand)
  vim.fn.system(docCommand)
  vim.cmd("e")
end, { silent = false, noremap = true, desc = "Php Doc Maker" })


map("n", "<leader>gfr",function ()
  local target = vim.fn.input("Text to replace:\n")
  local newValue = vim.fn.input("Text to replace with:\n")
  local workingDir = vim.fn.getcwd()
  local commandString = string.format("grep -rl --exclude-dir={node_modules,vendor,public} %s %s | xargs sed -i 's/%s/%s/g'", target, workingDir, target,newValue)
  --print(commandString)
  vim.fn.system(commandString)
end ,{desc="Find and replace whole project"})

-- Telescope formatting

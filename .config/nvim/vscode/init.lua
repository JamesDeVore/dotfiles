vim.cmd([[augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=200}
augroup END]])

vim.api.nvim_set_keymap("n", "<C-f>", "kkkk", {silent = false})
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("i", "jj", "<Esc>", { desc = "Escape" })

map("n", "<Leader>y", '"+y')
map("v", "<Leader>y", '"+y')

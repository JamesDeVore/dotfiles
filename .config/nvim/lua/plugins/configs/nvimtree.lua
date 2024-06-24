local nvim_tree = require 'nvim-tree'

map("n", "<C-s>", ":NvimTreeToggle<CR>")
map("n", "<C-c>", ":NvimTreeCollapse<CR>")

nvim_tree.setup {
 git = {
  ignore = false
 },
 hijack_cursor = true,
 update_focused_file = {
  enable = true
 },
 view = {
  width = 50,
 },
 diagnostics = {
  enable = true
 },
 actions = {
  open_file = {
   resize_window = true
  }
 }
}

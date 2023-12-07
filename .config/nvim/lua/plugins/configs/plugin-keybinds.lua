local wk = require("which-key")
local dap = require('dap')
wk.register({
  ["<leader>"] = {
    c = {
      i = { function() vim.lsp.buf.format() end, "Format" }
    },
  },
  {
    ["<C-s>"] = { ":NvimTreeToggle<CR>", "Toggle File Tree" }
  }
})
-- Debugging
map("n", "<M-b>", function() dap.toggle_breakpoint() end, { silent = true })
map("n", "<M-t>", function()
  -- vim.cmd("NvimTreeClose")
  dap.continue()
end, { silent = true, desc = "Start Session" })
map("n", "<M-s>", function() dap.step_over() end, { silent = true, desc = "Step Over" })
map("n", "<M-i>", function() dap.step_into() end, { silent = true, desc = "Step Into" })
map("n", "<M-u>", function() dap.step_out() end, { silent = true, desc = "Step Out" })
map("n", "<M-c>", function() dap.continue() end, { silent = true, desc = "Continue" })
map("n", "<M-f>", function() dap.run_to_cursor() end, { silent = true, desc = "Run to cursor" })
map("n", "<M-r>", function() dap.restart() end, { silent = true, desc = "Restart" })
map("n", "<M-a>", function() dap.list_breakpoints() end, { silent = true, desc = "List Breakpoints" })
map("n", "<M-d>", function()
  require('dap').clear_breakpoints()
end, { silent = true, desc = "Clear Breakpoints" })
map("n", "<M-q>", function()
  require('dap').close()
  require('dapui').close()
end, { silent = true, desc = "Quit Debugger" })


map("n", "<M-e>", function()
  vim.g.shouldCloseDapWins = 0
  require('dapui').eval()
end
, { silent = true, desc = "Evaluate" })

map("n", "<M-v>", "<cmd>:DapVirtualTextForceRefresh<cr>", { silent = true, desc = "Refresh Virtual Text" })
--map("n", "<M-t>", function() require('dapui').elements.scopes.open() end, { silent = true, desc = "" })
-- Comment
map("n", "<C-_>", ":lua require('Comment.api').toggle()<cr>")
map("x", "<C-_>", ":lua require('Comment.api').gc(vim.fn.visualmode())<cr>") -- Line Comment


--DAP ui
-- sets the variable back to close
function CloseDapWins()
  vim.g.shouldCloseDapWins = 1
  return ''
end

-- neogen
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
-- Nvim tree
local nvim_tree = require 'nvim-tree'
map("n", "<C-s>", ":NvimTreeToggle<CR>")
map("n", "<leader>t", function() nvim_tree.focus() end, { desc = 'Focus File Tree' })

-- Phpactor
map("n", "<leader>cp", function(buf)
  local filePath = vim.fn.expand('%')
  local returnDocCommand = "phpactor class:transform " .. filePath .. " --transform=add_missing_docblocks_return"
  local paramsCommand = "phpactor class:transform " .. filePath .. " --transform=add_missing_params"
  local returnCommand = "phpactor class:transform " .. filePath .. " --transform=add_missing_return_types"
  vim.fn.system(returnCommand)
  vim.fn.system(paramsCommand)
  vim.fn.system(returnDocCommand)
  vim.cmd("e")
end)
map("n", "<leader>cc", function(buf)
  local filePath = vim.fn.expand('%')
  local returnDocCommand = "phpactor class:transform " .. filePath .. " --transform=complete_constructor"
  local paramsCommand = "phpactor class:transform " .. filePath .. " --transform=implement_contracts"
  vim.fn.system(paramsCommand)
  vim.fn.system(returnDocCommand)
  vim.cmd("e")
end)

-- Telescope
local builtin = require 'telescope.builtin'
--[[ map('n', '<leader>ff', function() require("telescope.builtin").find_files { path_display = { "truncate" } }
end, { desc = "Find Files" })
map('n', '<leader>fb', function()
  require("telescope.builtin").buffers { path_display = { "truncate" } }
end, { desc = "Buffers" })
map('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" }) ]]
map('n', '<leader><space>', builtin.git_files, { desc = "List Git Files" })
map("n", "<leader>km", ":Telescope keymaps<CR>", { desc = "Telescope Keymaps" })
--[[ map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { silent = true, desc = "Telescope old files" }) ]]

local tp = require'plugins.telescopePickers'
map('n', '<leader>ff', function () tp.prettyFilesPicker({picker = 'find_files'}) end)
-- map('n', '<leader><space>', function () tp.prettyFilesPicker({picker = 'find_files'}) end)
map('n', '<leader>fg', function () tp.prettyGrepPicker({picker = 'live_grep'}) end)
map('n', '<C-n>', function () tp.prettyBufferPicker({picker = 'buffers'}) end)


-- Live grep stuff
vim.api.nvim_set_keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "Live Grep" })
-- map("n", "<leader>t", ":Telescope file_browser<CR>", { silent = true })
map("n", "<leader>o", ":Telescope file_browser path=%:p:h cwd_to_path=true<CR>", { silent = true })
map("n", "<C-n>", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })

local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
map("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "Grep word under cursor" })
map("v", "<leader>gv", live_grep_args_shortcuts.grep_visual_selection, { desc = "Grep Selection" })
require("telescope").load_extension "file_browser"

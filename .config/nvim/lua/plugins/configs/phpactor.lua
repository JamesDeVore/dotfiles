vim.cmd("autocmd FileType php setlocal omnifunc=phpactor#Complete")

map("n", "<leader>cp" ,function(buf)
local filePath = vim.fn.expand('%')
local returnDocCommand = "phpactor class:transform " .. filePath .. " --transform=add_missing_docblocks_return"
local paramsCommand = "phpactor class:transform " .. filePath .. " --transform=add_missing_params"
local returnCommand = "phpactor class:transform " .. filePath .. " --transform=add_missing_return_types"
  vim.fn.system(returnCommand)
  vim.fn.system(paramsCommand)
  vim.fn.system(returnDocCommand)
  vim.cmd("e")
end)
map("n", "<leader>cc" ,function(buf)
local filePath = vim.fn.expand('%')
local returnDocCommand = "phpactor class:transform " .. filePath .. " --transform=complete_constructor"
local paramsCommand = "phpactor class:transform " .. filePath .. " --transform=implement_contracts"
  vim.fn.system(paramsCommand)
  vim.fn.system(returnDocCommand)
  vim.cmd("e")
end)


vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })


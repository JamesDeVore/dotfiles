require 'mason'.setup()
require 'mason-lspconfig'.setup({
  automatic_installation = false
})

local lspconfig = require 'lspconfig'

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  bufopts.desc = "Declaration"
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)

  bufopts.desc = "Definition"
  map('n', 'gd', vim.lsp.buf.definition, bufopts)

  bufopts.desc = "Hover"
  map('n', 'K', vim.lsp.buf.hover, bufopts)

  bufopts.desc = "Implementation"
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  bufopts.desc = "Add Workspace Folder"
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)

  bufopts.desc = "Remove Workspace Folder"
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

  bufopts.desc = "List Worspace Folders"
  map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  bufopts.desc = "Type Definitions"
  map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

  bufopts.desc = "Rename"
  map('n', '<space>rn', vim.lsp.buf.rename, bufopts)

  bufopts.desc = "Code Action"
  map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

  bufopts.desc = "References"
  map('n', 'gr', vim.lsp.buf.references, bufopts)

  bufopts.desc = "Format File"
  map('n', '<space>bf', vim.lsp.buf.format, bufopts)

  --vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- sumneko_lua
require 'neodev'.setup {}
local neodev = {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
    },
  },
}

require('mason').setup({
  command = 'phpcbf',
  args = { '--standard=~/code/muiq1-web-app/.phpcs.xml', '--indent=spaces' },
  filetypes = { 'php' },
})

local phpcbf_config_path = "~/code/muiq1-web-app/.phpcs.xml"

-- Function to format using phpcbf
local function format_phpcbf()
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)
  local cmd = string.format("phpcbf --standard=%s %s", phpcbf_config_path, filepath)
  vim.fn.system(cmd)
  vim.cmd("edit")
end

-- Optional: Keymap to format manually
map('n', '<leader>ci', function()
  vim.lsp.buf.format()
  vim.cmd("write")
  format_phpcbf()
end, { noremap = true, silent = true })

require("mason-lspconfig").setup_handlers {
  function(server_name)
    lspconfig[server_name].setup { on_attach = on_attach, capabilities = capabilities }
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup(neodev)
  end,
  -- You can also override the default handler for specific servers by providing them as keys, like so:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
}

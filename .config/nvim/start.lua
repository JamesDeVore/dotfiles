require 'api'
if vim.g.vscode then
  -- VSCode extension
  require('vscode')
else
  require 'core'
  require 'plugins'
end

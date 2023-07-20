local dap = require 'dap'

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/james/Packages/vscode-php-debug/out/phpDebug.js' }
}


-- local dap, dapui = require("dap"), require("dapui")


require('dap.ext.vscode').load_launchjs("/home/james/code/muiq1-web-app/.vscode/launch.json")

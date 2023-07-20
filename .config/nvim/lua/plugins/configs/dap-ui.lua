require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

require("dapui").setup({
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      disconnect = "",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
  force_buffers = true,
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },
  layouts = { {
    elements = { {
      id = "repl",
      size = 0.15
    }, {
      id = "scopes",
      size = 0.25
    }, {
      id = "breakpoints",
      size = 0.25
    }, {
      id = "watches",
      size = 0.0
    } },
    position = "left",
    size = 50
  }, {
    elements = { {
      id = "stacks",
      size = 0.5
    }, {
      id = "console",
      size = 0.5
    } },
    position = "bottom",
    size = 10
  } },
  mappings = {
    edit = "e",
    expand = { "<CR>", "<LeftMouse>" },
    open = "o",
    remove = "d",
    repl = "r",
    toggle = "t"
  },
  render = {
    indent = 1,
    max_value_lines = 100
  }
})
vim.g.dapui_watches = false
local dap, dapui = require("dap"), require("dapui")


-- Function that closes ALL windows
local function closeFloaters()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win);
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false);
    end
  end
end

-- sets the variable back to close
function CloseDapWins()
  vim.g.shouldCloseDapWins = 1
  return ''
end


function PrintWordUnderCursor()
  local stop = "Stop"
  local sesh = dap.status()
  local stopped = string.find(sesh, stop)
  -- Evaluate the word if we're in a DAP session
  if stopped and vim.g.shouldCloseDapWins == 1 then
    closeFloaters()
    dapui.eval()
  end
  vim.cmd("DapVirtualTextForceRefresh")
end

vim.g.shouldCloseDapWins = 0

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
  -- vim.api.nvim_create_autocmd("CursorMoved", { callback = PrintWordUnderCursor })
  -- vim.cmd("autocmd CursorMoved * lua PrintWordUnderCursor()")
  -- vim.cmd("autocmd WinClosed * lua CloseDapWins()")
  -- vim.api.nvim_create_autocmd("WinClosed", { callback = CloseDapWins })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  -- vim.cmd("autocmd! WinClosed * lua CloseDapWins()")
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


-- Debugginer
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'red', linehl = 'DapBreakpoint', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'green', linehl = 'DapStopped', numhl = '' })
vim.api.nvim_set_hl(0, 'DapBreakpoint', { bold = true, underline = true })
vim.api.nvim_set_hl(0, 'DapStopped', { bold = true, underline = true, fg = '#e62747' })
--{ bg = '##ebc3c9' }
--
--

-- debugger
-- {

-- k = { function()
-- vim.cmd("NvimTreeClose")
-- dap.continue()
-- end, "Start Debugger" },
-- s = { function() dap.step_over() end, "Step Over" },
-- i = { function() dap.step_into() end, "Step Into" },
-- u = { function() dap.step_out() end, 'Step Out' },
-- c = { function() dap.continue() end, "Continue" },
-- j = { function() dap.run_to_cursor() end, "Run To Cursor" },
-- f = { function() dap.restart() end, "Restart" },
-- a = { function() dap.list_breakpoints() end, "List Breakpoints" },
-- d = { function()
-- require('dap').clear_breakpoints()
-- end, "Clear all Breakpoints" },
-- q = { function()
-- require('dap').close()
-- require('dapui').close()
-- end, "Close" },
-- h = { function() require('dapui').eval() end, "Expand Text" },
-- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
-- v = { "<cmd>:DapVirtualTextForceRefresh<cr>", "Refresh text" },
-- t = { function() require('dapui').elements.scopes.open() end, "Focus Debug Tray" }
-- }

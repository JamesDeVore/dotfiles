--require("nvim-dap-virtual-text").setup()
require("nvim-dap-virtual-text").setup {
  enabled = true,                   -- enable this plugin (the default)
  enabled_commands = true,          -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,          -- show stop reason when stopped for exceptions
  commented = false,                -- prefix virtual text with comment string
  only_first_definition = true,    -- only show virtual text at first definition (if there are multiple)
  all_references = false,            -- show virtual text on all all references of the variable (not only definitions)

  -- experimental features:
  virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
  -- virt_text_win_col = 80 -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

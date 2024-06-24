local wk = require("which-key")
local dap = require('dap')
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Register formatting on which key
wk.register({
  ["<leader>"] = {
    c = {
      i = { function() vim.lsp.buf.format() end, "Format" }
    },
  }
})

-- Debugging
local dap_mappings = {
  ["<M-b>"] = { function() dap.toggle_breakpoint() end, "Toggle Breakpoint" },
  ["<M-t>"] = { function() dap.continue() end, "Start Session" },
  ["<M-s>"] = { function() dap.step_over() end, "Step Over" },
  ["<M-i>"] = { function() dap.step_into() end, "Step Into" },
  ["<M-u>"] = { function() dap.step_out() end, "Step Out" },
  ["<M-c>"] = { function() dap.continue() end, "Continue" },
  ["<M-f>"] = { function() dap.run_to_cursor() end, "Run to Cursor" },
  ["<M-r>"] = { function() dap.restart() end, "Restart" },
  ["<M-a>"] = { function() dap.list_breakpoints() end, "List Breakpoints" },
  ["<M-d>"] = { function() dap.clear_breakpoints() end, "Clear Breakpoints" },
  ["<M-q>"] = { function()
    dap.close()
    require('dapui').close()
  end, "Quit Debugger" },
  ["<M-e>"] = { function()
    vim.g.shouldCloseDapWins = 0
    require('dapui').eval()
  end, "Evaluate" },
  ["<M-v>"] = { "<cmd>:DapVirtualTextForceRefresh<cr>", "Refresh Virtual Text" }
}

for key, mapping in pairs(dap_mappings) do
  if type(mapping[1]) == "function" then
    vim.keymap.set("n", key, mapping[1], { silent = true, desc = mapping[2] })
  else
    map("n", key, mapping[1], { silent = true, desc = mapping[2] })
  end
end

-- Comments
map("n", "<C-_>", ":lua require('Comment.api').toggle()<cr>", opts)
map("x", "<C-_>", ":lua require('Comment.api').gc(vim.fn.visualmode())<cr>", opts)

-- Neogen
map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)

-- Nvim Tree
local nvim_tree_mappings = {
  ["<C-s>"] = ":NvimTreeToggle<CR>",
  ["<leader>t"] = { ":NvimTreeFocus<CR>", "Focus File Tree" },
  ["<C-c>"] = ":NvimTreeCollapse<CR>"
}

for key, mapping in pairs(nvim_tree_mappings) do
  if type(mapping) == "table" then
    map("n", key, mapping[1], { silent = true, desc = mapping[2] })
  else
    map("n", key, mapping, opts)
  end
end

-- Phpactor
local phpactor_mappings = {
  ["<leader>cp"] = function()
    local filePath = vim.fn.expand('%')
    local commands = {
      "phpactor class:transform " .. filePath .. " --transform=add_missing_docblocks_return",
      "phpactor class:transform " .. filePath .. " --transform=add_missing_params",
      "phpactor class:transform " .. filePath .. " --transform=add_missing_return_types"
    }
    for _, cmd in ipairs(commands) do
      vim.fn.system(cmd)
    end
    vim.cmd("e")
  end,
  ["<leader>cc"] = function()
    local filePath = vim.fn.expand('%')
    local commands = {
      "phpactor class:transform " .. filePath .. " --transform=complete_constructor",
      "phpactor class:transform " .. filePath .. " --transform=implement_contracts"
    }
    for _, cmd in ipairs(commands) do
      vim.fn.system(cmd)
    end
    vim.cmd("e")
  end
}

for key, func in pairs(phpactor_mappings) do
  vim.keymap.set("n", key, func, opts)
end

-- Telescope
local telescope = require('telescope.builtin')
local tp = require('plugins.telescopePickers')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

local telescope_mappings = {
  ["<leader><space>"] = { telescope.git_files, "List Git Files" },
  ["<leader>km"] = { ":Telescope keymaps<CR>", "Keymaps" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
  ["<leader>ff"] = { function() tp.prettyFilesPicker({ picker = 'find_files' }) end, "Find Files" },
  ["<leader>fg"] = { function() tp.prettyGrepPicker({ picker = 'live_grep' }) end, "Live Grep" },
  ["<C-n>"] = { function() tp.prettyBufferPicker({ picker = 'buffers' }) end, "Buffers" },
  ["<leader>fg"] = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Live Grep Args" },
  ["<leader>o"] = { ":Telescope file_browser path=%:p:h cwd_to_path=true<CR>", "File Browser" },
  ["<leader>gc"] = { live_grep_args_shortcuts.grep_word_under_cursor, "Grep Word Under Cursor" },
  ["<leader>gv"] = { live_grep_args_shortcuts.grep_visual_selection, "Grep Selection" }
}

for key, mapping in pairs(telescope_mappings) do
  if type(mapping[1]) == "function" then
    vim.keymap.set("n", key, mapping[1], { desc = mapping[2] })
  else
    map("n", key, mapping[1], { noremap = true, silent = true, desc = mapping[2] })
  end
end

require("telescope").load_extension("file_browser")

-- Close Dap Wins
function CloseDapWins()
  vim.g.shouldCloseDapWins = 1
  return ''
end


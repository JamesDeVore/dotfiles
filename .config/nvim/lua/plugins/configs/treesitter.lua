require 'nvim-treesitter.configs'.setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  ensure_installed = { "html", "php", "javascript", "lua", "vim" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
   -- disable = { 'vue', 'html' }
  },
  auto_install = false,
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm'
    }
  }
}

local has_tsc, tsc = pcall(require, 'treesitter-context')
if has_tsc then
  tsc.setup {}
end
vim.cmd('autocmd BufRead,BufNewFile *.vue set filetype=javascript')

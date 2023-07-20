local has_ls, ls = pcall(require, 'luasnip')
if not has_ls then return true end
-- local luasnip = require('luasnip')


local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

local sep = "-----------------------------------------------------"
--
-- ls.config.set_config({
--   history = true,
--   updateevents = "TextChanged,TextChangedI",
--   enable_autosnippets = true,
--     ext_prio_increase = 1
-- })
ls.config.set_config({
  history = false
})

-- ls.add_snippets("all", {
--   s("phpd", fmt(
--       "// Debugging {name} \n file_put_contents('/var/www/html/tmp/debug.log', PHP_EOL.'{sep}'.'{name}'.'{sep}'.json_encode($data, JSON_PRETTY_PRINT).PHP_EOL, FILE_APPEND | LOCK_EX );"
--     , {
--       i(0, "variable name"),
--       name = f(0, 'name'),
--       sep = sep
--     })
--   )
-- })
--vim.cmd([[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ]])
vim.cmd([[inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>]])

ls.add_snippets("all", {
  ls.parser.parse_snippet({ trig = "phpd" }, [[
// Debugging: \$$1
file_put_contents('/var/www/html/tmp/debug.log', PHP_EOL.str_repeat('-', 30).PHP_EOL.'$1'.PHP_EOL.str_repeat('-', 30).PHP_EOL.json_encode(\$$1, JSON_PRETTY_PRINT).PHP_EOL, FILE_APPEND | LOCK_EX );
    ]]
  )
})
require('luasnip/loaders/from_vscode').lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

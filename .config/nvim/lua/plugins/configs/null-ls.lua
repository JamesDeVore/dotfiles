local null_ls = require('null-ls')


local sources = {
  null_ls.builtins.formatting.eslint_d.with({
    filetypes = { "javascript", "html", "vue" }
  }),
  null_ls.builtins.code_actions.eslint_d.with({
    filetypes = { "javascript" }
  }),
  null_ls.builtins.diagnostics.eslint_d.with({
    filetypes = { "javascript" },
    disables_filetypes = { "html" }
  }),
  null_ls.builtins.diagnostics.phpcs,
  null_ls.builtins.formatting.phpcbf,
--  null_ls.builtins.diagnostics.phpstan
}
null_ls.setup({ sources = sources })

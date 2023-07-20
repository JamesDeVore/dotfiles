local opt = vim.opt

opt.cursorline = true

opt.laststatus = 3
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.number = true
opt.numberwidth = 2
opt.ruler = false

opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

opt.updatetime = 250

opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.completeopt = "menu,menuone,noselect"

require'core.keybinds'


vim.api.nvim_set_hl(0, 'Search', { bg = '#698a81' })
-- vim.cmd("set listchars=tab:▸\\ ,eol:¬")
vim.cmd([[set listchars=tab:..]])
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

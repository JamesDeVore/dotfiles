local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-lua/plenary.nvim", -- Async

	{
		"olimorris/onedarkpro.nvim",
		init = function()
			vim.cmd([[ colorscheme onedark ]])
			vim.api.nvim_set_hl(0, 'Search', { bg = '#698a81' })
		end,
		priority = 100,
		lazy = false,
	},

	{ "kyazdani42/nvim-web-devicons", lazy = true },
	-- IDE --
	{
		"neovim/nvim-lspconfig",
		config = function()
			require('plugins.configs.lspconfig')
		end
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("plugins.configs.mason")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			'nvim-treesitter/playground'
		},
		priority = 120,
		lazy = false,
		cmd = "TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("plugins.configs.virtual-text")
		end
	},

	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
	},

	{
		"mxsdev/nvim-dap-vscode-js",
		config = function()
			require('plugins.configs.nvim-dap-vscode-js')
		end
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require('plugins.configs.dap')
			require('plugins.configs.dap-ui')
		end,
	},
	{
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_enabled = 1
			vim.g.gitblame_message_when_not_committed = ''
			vim.g.gitblame_display_virtual_text = 1
		end
	},

	{
		"kdheepak/lazygit.nvim",
		config = function()
			map("n", "<leader>lg", "<cmd>:LazyGit<cr>")
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require 'plugins.configs.null-ls'
		end
	},
	"folke/trouble.nvim", -- Trouble Menu
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("plugins.configs.nvimtree")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			--require('plugins.configs.telescope-file')
		end
	},
	"digitaltoad/vim-pug",

	{
		"mbbill/undotree",
		config = function()
			-- require'plugins.configs.undotree'
			vim.api.nvim_set_keymap("n", "<Leader>uu", ":UndotreeToggle<CR>", { silent = false })
			vim.opt.undofile = true
			vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"lukas-reineke/cmp-under-comparator",
			"andersevenrud/cmp-tmux",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			require("plugins.configs.luasnip")
		end
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.configs.colorizer")
		end,
	},

	{
		'heavenshell/vim-jsdoc',
		build = "make clean && make install",
		config = function()
			vim.cmd([[let g:jsdoc_templates_path="/home/james/DevResources/pluginFiles/jsdoctmpl.js"]])
		end
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.comment")
		end,
	},

	{
		'phpactor/phpactor',
		config = function() require('plugins.configs.phpactor') end
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require('plugins.configs.neogen')
		end,
		-- Uncomment next line if you want to follow only stable versions
		version = "*"
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},

	{
		"NMAC427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},

	{
		"anuvyklack/hydra.nvim",
		config = function()
			--require'plugins.configs.hydra'
		end,
	},


	{
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.configs.diffview")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		config = function()
			-- require'plugins.configs.bufferline'
			require("bufferline").setup({
				options = {
					tab_size = 25
				}
			})
		end,
	},

	-- Performance --
	{
		"lewis6991/impatient.nvim",
		init = function()
			require("impatient")
		end,
		priority = 999,
		lazy = false,
	},

	-- Util
	--"christoomey/vim-tmux-navigator", -- Move Splits Using <C-{h/j/k/l}>
	{
		"echasnovski/mini.nvim",
		config = function()
			require("plugins.configs.mini")
		end,
	},
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require('plugins.configs.autosave')
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-live-grep-args.nvim"
		},
		config = function()
			require("plugins.configs.telescope")
		end,
	},
	{
		"folke/noice.nvim",
		config = function()
			require("plugins.configs.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 800
			require("plugins.configs.which-key")
		end,
	},
	"gioele/vim-autoswap",
	"kdheepak/lazygit.nvim",
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" }
}

local opts = {}

require("lazy").setup(plugins, opts)
require("plugins.configs.plugin-keybinds")

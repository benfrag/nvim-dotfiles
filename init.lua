vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.cmd("set number")
vim.cmd("set signcolumn=yes")

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			highlight = { enable = true },
		})
	end,
},
{
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup()
		vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
	end,
},
{
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe"
		})
		vim.cmd.colorscheme "catppuccin"
	end, 
},
{
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		lspconfig.clangd.setup({})
		lspconfig.intelephense.setup({})
		lspconfig.omnisharp.setup({})
		lspconfig.tsserver.setup({})

	end,

},
{
	"hrsh7th/nvim-cmp",
},
{
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup()
	end,
},
{
	"tpope/vim-sleuth",
},
{
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = 'auto',
			},
		})
	end,
},
})

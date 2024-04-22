--vim.opt.autoindent = true
--vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.cmd("set number")
vim.cmd("set signcolumn=yes")
vim.opt.confirm = true

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
			indent = { enable = true },
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
--[[{
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe"
			--flavour = "latte"
		})
		vim.cmd.colorscheme "catppuccin"
	end, 
},--]]
--[[{
	"pbrisbin/vim-colors-off",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "off"
	end,
},]]--
--[[{
	"zekzekus/menguless",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "menguless_light"
	end,
},]]--
	{
		dependencies = {
			"rktjmp/lush.nvim",
		},
		"mcchrish/zenbones.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("set termguicolors")
			vim.cmd("set background=light")
			vim.cmd.colorscheme "zenbones"
		end,

	},
--[[{
	"rose-pine/neovim",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			styles = {
				italic = false,
			},
			highlight_groups = { EndOfBuffer = { fg = "base" } },
		})
		vim.cmd.colorscheme "rose-pine-main"
	end,

},]]--
{
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		lspconfig.clangd.setup({})
		lspconfig.intelephense.setup({})
		lspconfig.omnisharp.setup({})
		lspconfig.tsserver.setup({})
              lspconfig.tailwindcss.setup({
	capabilities = capabilities,
      })
	    lspconfig.pyright.setup({
	      capabilities = capabilities,
	    })
	end,

},
  {
        "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
	completion = {
	  autocomplete = false
	},
                mapping = cmp.mapping.preset.insert({
	   ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

        -- Navigate through the completion menu
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),

        -- Close the completion menu
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        -- Confirm the selected completion item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' }
                })
            })

            -- Setup command line completion
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
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
{
	'xeluxee/competitest.nvim',
	dependencies = 'MunifTanjim/nui.nvim',
	config = function() require('competitest').setup() end,
},
})

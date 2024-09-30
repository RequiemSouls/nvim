vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
	use 'wbthomason/packer.nvim' 

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')

			vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
			vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
		end
	}

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('nvim-treesitter/playground')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
	use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
	use({'neovim/nvim-lspconfig'})
	use({'hrsh7th/nvim-cmp'})
	use({'hrsh7th/cmp-nvim-lsp'})
	use({ "williamboman/mason.nvim" })
end)

require("options")
require("remap")
require("treesitter")
require("lsp")


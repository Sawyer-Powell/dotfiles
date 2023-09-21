call plug#begin()
	" For clojure
	Plug 'Olical/conjure'

	" For toggle term
	Plug 'akinsho/toggleterm.nvim'

	" For obsidian
	Plug 'epwalsh/obsidian.nvim'

	" For .ENV file parsing
	Plug 'tpope/vim-dotenv'

	Plug 'kylechui/nvim-surround'
	Plug 'HiPhish/nvim-ts-rainbow2'

	" SQL stuff
	Plug 'tpope/vim-dadbod'
	Plug 'kristijanhusak/vim-dadbod-ui'
	Plug 'kristijanhusak/vim-dadbod-completion'

	Plug 'williamboman/mason.nvim'

	" Shows the current context 
	Plug 'nvim-treesitter/nvim-treesitter-context'

	" Show tab lines
	Plug 'lukas-reineke/indent-blankline.nvim'

	" Debugger
	Plug 'mfussenegger/nvim-dap'
	
	" Autocloses brackets, quotations, etc
	Plug 'm4xshen/autoclose.nvim'

	" Module used as base for others
	Plug 'nvim-lua/plenary.nvim',

	" For lsp
	Plug 'neovim/nvim-lspconfig',
	Plug 'hrsh7th/cmp-nvim-lsp',
	Plug 'rafamadriz/friendly-snippets',
	Plug 'hrsh7th/nvim-cmp',
	Plug 'L3MON4D3/LuaSnip',

	" Rose Pine theme
	Plug 'projekt0n/github-nvim-theme'

	Plug 'nvim-treesitter/nvim-treesitter',
	Plug 'ThePrimeagen/harpoon',
	Plug 'nvim-telescope/telescope.nvim'

call plug#end()

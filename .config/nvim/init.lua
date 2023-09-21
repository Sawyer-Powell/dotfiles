local vimrc = vim.fn.stdpath("config") .. "/plugins.vim"

vim.cmd.source(vimrc)
vim.cmd('colorscheme github_dark')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

vim.cmd('set cursorline')
vim.cmd('highlight CursorLine guibg=#0d1117')
vim.cmd('set colorcolumn=80')

local source_config = function()
	local init = vim.fn.stdpath("config").."/init.lua"
end

local source_config_install_plugs = function()
	source_config()
	vim.cmd.source(init)
	vim.cmd('PlugInstall')
	--vim.cmd('PlugClean')
end

local reload_buf = function()
	vim.cmd("e!")
end

-- Autocommands
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	pattern = {"*.clj"},
	callback = function(ev) 
		local Job = require('plenary.job')
		Job:new({
			command = "cljfmt",
			args = {"fix"},
			on_stdout = function(_, _)
			end,
			on_exit = function()
				vim.schedule(reload_buf)
			end,
		}):start()
	end
})



-- Editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 
vim.g.mapleader = ' '
vim.g.maplocalleader = ","

-- Keybindings
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>S', source_config_install_plugs, {desc = 'source and get plugins'})
vim.keymap.set('n', '<leader>s', source_config)
vim.keymap.set('n', '<leader>q', '<cmd>wq<cr>') --Write and quit nvim
vim.keymap.set('n', '<leader>Q', '<cmd>q!<cr>')
vim.keymap.set('n', '<leader>e', '<cmd>Explore<cr>')
vim.keymap.set('n', 'L', 'ddO')
vim.keymap.set('n', '<C-l>', '<C-w><Right>')
vim.keymap.set('n', '<C-h>', '<C-w><Left>')
vim.keymap.set('n', '<C-j>', '<C-w><Down>')
vim.keymap.set('n', '<C-k>', '<C-w><Up>')
vim.keymap.set('n', '<leader><tab>', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>tq', '<cmd>tabclose<cr>')
vim.keymap.set('n', '<leader>tt', '<cmd>tab new<cr>')

-- Dadbod
vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<cr>')
vim.keymap.set('n', '<leader>dl', '<cmd>DBUIFindBuffer<cr>')
vim.keymap.set({'n', 'x'}, '<leader>c', '"+y')
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p')

--vim.keymap.set('i', '"', '""<left>')
--vim.keymap.set('i', "'", "''<left>")
--vim.keymap.set('i', "(", "()<left>")
--vim.keymap.set('i', '[', "[]<left>")
--vim.keymap.set('i', '{', '{}<left>')
--vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O')

-- Harpoon Keybindings
require("harpoon").setup({
	global_settings = {
		enter_on_sendcmd = true,
		tmux_autoclose_windows = true,
	}
})

vim.keymap.set('n', '<leader>a', function()
	require("harpoon.mark").add_file()
end)
vim.keymap.set('n', '<leader>r', function()
	require("harpoon.mark").clear_all()
end)
vim.keymap.set('n', '<leader>h', function()
	require("harpoon.ui").toggle_quick_menu()
end)
vim.keymap.set('n', '<leader>1', function()
	require("harpoon.ui").nav_file(1)
end)
vim.keymap.set('n', '<leader>2', function()
	require("harpoon.ui").nav_file(2)
end)
vim.keymap.set('n', '<leader>3', function()
	require("harpoon.ui").nav_file(3)
end)
vim.keymap.set('n', '<leader>4', function()
	require("harpoon.ui").nav_file(4)
end)
vim.keymap.set('n', '<leader>5', function()
	require("harpoon.ui").nav_file(5)
end)
vim.keymap.set('n', '<leader>6', function()
	require("harpoon.ui").nav_file(6)
end)
vim.keymap.set('n', '<leader>hc', function()
	require("harpoon.cmd-ui").toggle_quick_menu()
end)
vim.keymap.set('n', '<leader><enter><enter>', function()
	require("harpoon.tmux").gotoTerminal(1)
	require("harpoon.tmux").sendCommand(1, 1)
end)
vim.keymap.set('n', '<leader><enter>2', function()
	require("harpoon.tmux").gotoTerminal(1)
	require("harpoon.tmux").sendCommand(2, 1)
end)
vim.keymap.set('n', '<leader><enter>3', function()
	require("harpoon.tmux").gotoTerminal(1)
	require("harpoon.tmux").sendCommand(3, 1)
end)
vim.keymap.set('n', '<leader><enter>4', function()
	require("harpoon.tmux").gotoTerminal(1)
	require("harpoon.tmux").sendCommand(4, 1)
end)
vim.keymap.set('n', '<leader><enter>5', function()
	require("harpoon.tmux").gotoTerminal(1)
	require("harpoon.tmux").sendCommand(5, 1)
end)


-- Autoclose
require("autoclose").setup()

-- Telescope Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fa', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fi', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('v', '<leader>f', builtin.grep_string, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {})

-- TreeSitter configuration
local rainbow = require'ts-rainbow'
require('nvim-treesitter.configs').setup {
	rainbow = {
		enable = true,
		strategy = rainbow.strategy.global,
		hlgroups = {
		   'TSRainbowYellow',
		   'TSRainbowGreen',
		   'TSRainbowOrange',
		   'TSRainbowBlue',
		   'TSRainbowCyan',
		},
	},
	ensure_installed = {
		"javascript",
		"c_sharp",
		"typescript",
		"vim",
		"lua",
		"vimdoc",
		"html",
		"json",
		"markdown",
		"markdown_inline"
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown" },
	},
}

--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"

require'treesitter-context'.setup{}
require'indent_blankline'.setup{}
require'mason'.setup{}

-- Dadbod UI
vim.g.db_ui_auto_execute_table_helpers = 1

-- Autoclose
require('autoclose').setup({
	keys = {
		["'"] = {escape=true, pair="''", close=true, disabled_filetypes = {"clojure", "vim"}}
	},
	options = {
		disabled_filetypes = {"text", "markdown"}
	}
})


require('nvim-surround').setup({})


-- SPUX
vim.keymap.set('n', '<leader><enter>', function()
	local status, output, exit_code = os.execute(vim.env.SPUX_CMD_0)
	if status then
		print("$SPUX_CMD_0 executed successfully.")
	else
		print("Error executing $SPUX_CMD_0.")
	end
end)

vim.keymap.set('n', '<leader><leader>1', function()
	local status, output, exit_code = os.execute(vim.env.SPUX_CMD_1)
	if status then
		print("$SPUX_CMD_1 executed successfully.")
	else
		print("Error executing $SPUX_CMD_0.")
	end
end)

vim.keymap.set('n', '<leader><leader>2', function()
	local status, output, exit_code = os.execute(vim.env.SPUX_CMD_2)
	if status then
		print("$SPUX_CMD_2 executed successfully.")
	else
		print("Error executing $SPUX_CMD_0.")
	end
end)

-- Obsidian
require'obsidian'.setup {
	dir = "~/Documents/svault",
	completion = {
		nvim_cmp = true,
	},
	mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = require("obsidian.mapping").gf_passthrough(),
	},
	finder = "telescope.nvim",
	note_id_func = function(title)
		local suffix = ""
		if title ~= nil then
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		end
		if suffix ~= "" then
			return tostring(os.time()) .. "-" .. suffix
		else
			return tostring(os.time())
		end
	end
}

vim.keymap.set('n', '<leader>of', "<cmd>ObsidianQuickSwitch<cr>")
vim.keymap.set('n', '<leader>ol', "<cmd>ObsidianFollowLink<cr>")
vim.keymap.set('n', '<leader>ob', "<cmd>ObsidianBacklinks<cr>")
vim.keymap.set('n', '<leader>oa', "<cmd>ObsidianSearch<cr>")
vim.keymap.set('n', '<leader>on', ":ObsidianNew ")

-- Toggle term

require'toggleterm'.setup {
	direction = 'tab',
}

local Terminal = require'toggleterm.terminal'.Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	close_on_exit = true,
})

function _lazygit_toggle()
	lazygit:toggle()
end

vim.keymap.set('n', '<leader>g', _lazygit_toggle)

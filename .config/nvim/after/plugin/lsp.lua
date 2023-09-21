-- LSP Configuration
local lspconfig = require('lspconfig')

local configPath = vim.fn.stdpath("config")
local languageServerPath = configPath.."/languageserver"

-- Configuring lua snip
require("luasnip.loaders.from_vscode").lazy_load()

-- Autocompletion configuration

local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'vim-dadbod-completion'},
	}, {
		{ name = 'buffer' },
	})
})

vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = {"sql", "mysql", "plsql"},
	command = "lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setting up specific language servers

local angular_cmd = {
	"node",
	languageServerPath.."/node_modules/@angular/language-server/index.js",
	"--stdio",
	"--tsProbeLocations",
	languageServerPath,
	"--ngProbeLocations",
	languageServerPath
}

lspconfig.angularls.setup {
	capabilites = capabilities,
	on_attach = on_attach_common,
	cmd = angular_cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = angular_cmd
	end,
}

lspconfig.html.setup {
	capabilities = capabilities,
	cmd = {
		"/home/sawyer/.local/share/nvim/mason/bin/clojure-lsp"
	},
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = {
			"/home/sawyer/.local/share/nvim/mason/bin/clojure-lsp"
		}
	end
}

lspconfig.clojure_lsp.setup {
	capabilities = capabilities
}

lspconfig.jedi_language_server.setup{
	capabilities = capabilities
}

lspconfig.tsserver.setup {
	capabilities = capabilities
}

lspconfig.clangd.setup {
	capabilities = capabilities
}

lspconfig.gopls.setup {
	capabilities = capabilities
}

lspconfig.omnisharp.setup {
	capabilities = capabilities,
	cmd = {"/home/sawyer/.local/share/nvim/mason/bin/omnisharp"},
	
	-- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
}

vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float)
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		vim.keymap.set('i', '<C-l>', '<c-x><c-o>', opts)

		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
		  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { 
				{
					tabSize=4,
					insertSpaces=false,
					trimTrailingWhitespace=true,
				},
				async = true 
			}
		end, opts)
	end,
})



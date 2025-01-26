return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- local isMac = vim.loop.os_uname().sysname == "Darwin"
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "omnisharp" },
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local isMac = vim.loop.os_uname().sysname == "Darwin"
			local tsserver = lspconfig.ts_ls
			tsserver.setup({
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "non-relative",
						importModuleSpecifierEnding = "minimal",
						renameMatchingJsxTag = true,
						jsxAttributeCompletionStyle = "auto",
					},
				},
			})
			lspconfig.gopls.setup({
				cmd = { "gopls" },
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
				on_attach = function() end,
			})
			lspconfig.lua_ls.setup({})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			lspconfig.omnisharp.setup({
				cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" },
				capabilities = capabilities,
				root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj"),
			})
		end,
	},
}

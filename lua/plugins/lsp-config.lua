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
      local isMac = vim.loop.os_uname().sysname == "Darwin"
      local tsserver = isMac and "tsserver" or "ts_ls"
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", tsserver },
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
      local tsserver = isMac and lspconfig.tsserver or lspconfig.ts_ls
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
				on_attach = function()
				end,
			})
			lspconfig.lua_ls.setup({})
		end,
	},
}

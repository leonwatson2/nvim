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
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
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

			lspconfig.tsserver.setup({
				init_options = {
					preferences = {
						-- other preferences...
						importModuleSpecifierPreference = "non-relative",
						importModuleSpecifierEnding = "minimal",
						renameMatchingJsxTag = true,
						jsxAttributeCompletionStyle = "auto",
					},
				},
			})
			lspconfig.lua_ls.setup({})
		end,
	},
}

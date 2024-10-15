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
				ensure_installed = { "lua_ls", "gopls" },
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
            jsxAttributeCompletionStyle = "auto"
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
                on_attach = function(client, bufnr)
                    -- You can add any additional setup needed for gopls here,
                    -- but keybindings are already handled in your keybinds.lua.
                end,
            })
			lspconfig.lua_ls.setup({})
		end,
	},
}

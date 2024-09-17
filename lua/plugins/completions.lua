return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "onsails/lspkind-nvim",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "mlaursen/vim-react-snippets",
    },
    config = function()
      -- Set up nvim-cmp.
      local cmp = require("cmp")

--      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            require("vim-react-snippets").lazy_load()
          end,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function (entry, vim_item)

            local menu_items = {
              luasnip = "✂",
              nvim_lsp = "🔨",
              buffer = "📦",
              nvim_lua = "",
              treesitter = "",
              path = "🛣",
              zsh = "",
              vsnip = "",
              spell = "暈",
            }

            if menu_items[entry.source.name] then
              vim_item.menu = menu_items[entry.source.name]
            else
              vim_item.menu = entry.source.name
            end
           return vim_item
          end
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<S-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Enter>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "vim-react-snippets" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}

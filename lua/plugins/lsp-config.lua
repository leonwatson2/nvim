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
        ensure_installed = { "lua_ls", "tsserver", "cssls" },
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
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      lspconfig.cssls.setup({
        filetypes = { "css", "scss", "less" },
        capabilities = capabilities,
      })
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

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local function setup_formatting()
      local pco_workspace_path = vim.fn.getcwd() .. "/pco.code-workspace"
      if vim.fn.filereadable(pco_workspace_path) == 1 then
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.prettier.with({
              extra_args = { "--config", pco_workspace_path }
            })
          }
        })

        vim.opt.expandtab = false -- converts tabs to white space "
        print("Using pco-code.workspace formatting")
      else
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettier,
            require("none-ls.diagnostics.eslint_d"),
          },
        })
        print("Using default formatting")
      end
    end
    setup_formatting()
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

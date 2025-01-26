return {
  "nvim-treesitter/nvim-treesitter", commit = "425b589", build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")

    config.setup({
      ensure_installed = { "lua", "javascript", "typescript", "css" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

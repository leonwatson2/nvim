return {
  "tiagovla/tokyodark.nvim",
  opts = {
    -- custom options here
    comments = { italics = true },
  },
  config = function(_, opts)
    require("tokyodark").setup(opts) -- calling setup is optional
    vim.cmd.colorscheme "tokyodark"
  end,
}

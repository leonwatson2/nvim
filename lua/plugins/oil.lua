return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function ()
    require('oil').setup()
    vim.keymap.set("n", "<leader>n","<cmd>lua require('oil').toggle_float()<CR>", {})

  end
}

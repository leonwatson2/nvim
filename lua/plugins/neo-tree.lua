return 
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true, -- hidden files can be toggled with shift+h
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = {},
        },
      }
    },
    config = function()
      vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>', {})
    end

}


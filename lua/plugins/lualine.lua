return  {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- install nerd fonts curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'dracula',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
    })
  end

}


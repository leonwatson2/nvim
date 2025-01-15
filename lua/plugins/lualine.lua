return  {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- install nerd fonts curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'horizon',
        -- Uncomment on windows terminals, or install https://wezfurlong.org/wezterm/installation.html
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1
          }
        }

      }
    })
  end

}


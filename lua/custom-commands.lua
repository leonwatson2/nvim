

vim.api.nvim_create_user_command("Config", function ()
  local osName = vim.loop.os_uname().sysname
  if(osName == "Windows_NT") then
    vim.cmd("cd ~/AppData/Local/nvim")
  elseif(osName == "Darwin") then
    vim.cmd("~/.config/nvim")
  end
  vim.cmd(":Neotree filesystem reveal left<CR>")

end, {})
 vim.api.nvim_create_user_command("Fun", function ()
  local osName = vim.loop.os_uname().sysname
  if(osName == "Windows_NT") then
    vim.cmd("cd ~/Coding")
  end
  vim.cmd(":Neotree filesystem reveal left<CR>")
end, {})

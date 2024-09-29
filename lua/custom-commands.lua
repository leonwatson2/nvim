

vim.api.nvim_create_user_command("Config", function ()
  local osName = vim.loop.os_uname().sysname
  if(osName == "Windows_NT") then
    vim.cmd("cd ~/AppData/Local/nvim")
  elseif(osName == "Darwin") then
    vim.cmd("cd ~/.config/nvim/")
  end
  vim.cmd(":Neotree reveal <CR>")

end, {})
 vim.api.nvim_create_user_command("Fun", function ()
  vim.cmd("cd ~/Coding")
  vim.cmd(":Neotree reveal <CR>")
end, {})
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd("noh")
  end,
})


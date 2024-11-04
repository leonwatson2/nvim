vim.cmd("let g:netrw_liststyle = 3")
vim.opt.expandtab = true -- converts tabs to white space "
vim.opt.tabstop = 2 -- number of columns occupied by a tab"
vim.opt.softtabstop = 2 -- how much to delete when backspacing"
vim.opt.shiftwidth = 2 -- amount of indentation used when using shiift commands e.g.(shift + >>)"
vim.opt.number = true -- show line numbers and relative numbers
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.backspace = "indent,start,eol"
vim.opt.splitright = true

local osName = vim.loop.os_uname().sysname
vim.opt.splitbelow = true
if(osName == "Windows_NT") then
  vim.opt.shell = 'cmd.exe'
elseif(osName == "Darwin") then
  vim.opt.shell = '/bin/bash'
end


vim.g.mapleader = " "

-- window navigations 
vim.api.nvim_set_keymap('n', '<Leader>hh', '<C-w>h', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>jj', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>kk', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ll', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tt', '<C-w>t', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>pp', '<C-w>p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ww', '<C-w>w', { noremap = true, silent = true })
-- Copy current line up (Alt-J) or down (Alt-K) 
vim.api.nvim_set_keymap('n', '<A-J>', ':.t.<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-K>', ':.t-1<CR>', { noremap = true, silent = true })


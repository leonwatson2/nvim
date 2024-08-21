
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<ESC>", { desc = "Leaves Insert Mode"})

-- window navigations 
vim.keymap.set('n', 'wy', '<C-w>h', { noremap = true, silent = false })
vim.keymap.set('n', 'wj', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', 'wk', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', 'wl', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>tt', '<C-w>t', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>pp', '<C-w>p', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>ww', '<C-w>w', { noremap = true, silent = true })

-- Copy current line up (Alt-J) or down (Alt-K) 
vim.keymap.set('n', '<A-K>', ':m-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-J>', ':m+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-S-Down>', ':m+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-S-Up>', ':m-2<CR>==', { noremap = true, silent = true })

-- terminal exit commands
vim.keymap.set('t', '<C-d>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', '<ESC>', [[<C-d>]], { noremap = true })

-- copy paste commands
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', '<C-e>', '"+y', { noremap = true, silent = true })

vim.keymap.set('n', '<C-Z>', ':w', { noremap = true, silent = true })

vim.keymap.set('n', 'w', '<nop>')

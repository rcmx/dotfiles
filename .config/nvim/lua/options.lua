-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true


-- line
vim.opt.cursorline = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.laststatus = 3

-- set leader key to space
vim.g.mapleader = " "

vim.diagnostic.config({ virtual_lines = { current_line = true } })


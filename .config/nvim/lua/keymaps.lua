vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- navigation
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = 'Goto Previous Buffer', silent = true })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Goto Next Buffer', silent = true })


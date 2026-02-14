vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- navigation - scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { noremap = true, silent = true })

-- navigation bufers
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = 'Goto Previous Buffer', silent = true })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Goto Next Buffer', silent = true })
vim.keymap.set('n', '<C-left>', ':bprev<CR>', { desc = 'Goto Previous Buffer', silent = true })
vim.keymap.set('n', '<C-right>', ':bnext<CR>', { desc = 'Goto Next Buffer', silent = true })

-- navigation code
vim.keymap.set("n", "]m", "]mzz", { noremap = true, silent = true })
vim.keymap.set("n", "[m", "[mzz", { noremap = true, silent = true })

-- windows

-- quicklist
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { noremap = true, silent = true })




vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- navigation - scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- navigation bufers
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = 'Goto Previous Buffer', silent = true })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Goto Next Buffer', silent = true })
vim.keymap.set('n', '<C-left>', ':bprev<CR>', { desc = 'Goto Previous Buffer', silent = true })
vim.keymap.set('n', '<C-right>', ':bnext<CR>', { desc = 'Goto Next Buffer', silent = true })

-- -- navigation code
-- vim.keymap.set("n", "[[", "?{<CR>w99[{", { desc = 'Goto Previous {', noremap = true, silent = true })
-- vim.keymap.set("n", "]]", "j0[[%/{<CR>", { desc = 'Goto Next {', noremap = true, silent = true })
-- vim.keymap.set("n", "][", "/}<CR>b99]}", { desc = 'Goto End of function', noremap = true, silent = true })
-- vim.keymap.set("n", "[]", "k$][%?}<CR>", { desc = 'Goto Start of function', noremap = true, silent = true })

-- quicklist
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { noremap = true, silent = true })




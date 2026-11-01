vim.keymap.set("i", "jj", "<Esc>", { silent = true })

-- navigation - scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { silent = true })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { silent = true })

-- navigation - buffers
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Goto Previous Buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Goto Next Buffer" })
vim.keymap.set("n", "<C-left>", "<cmd>bprev<CR>", { desc = "Goto Previous Buffer" })
vim.keymap.set("n", "<C-right>", "<cmd>bnext<CR>", { desc = "Goto Next Buffer" })

-- navigation - code: ]m / [m live in plugins/treesitter.lua

-- quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>", { desc = "Previous Quickfix Item" })

vim.keymap.set("i", "jj", "<Esc>", { silent = true })

-- navigation - scrolling
-- Scroll and center in a single :normal! so no WinScrolled fires between the
-- scroll and the zz. As a plain "<C-f>zz" rhs, snacks.scroll starts animating
-- after <C-f> and the zz lands on the pre-scroll view (<C-f>/<C-b> only).
for _, key in ipairs({ "<C-u>", "<C-d>", "<C-b>", "<C-f>" }) do
  local keys = vim.keycode(key) .. "zz"
  vim.keymap.set("n", key, function()
    vim.cmd.normal({ (vim.v.count > 0 and vim.v.count or "") .. keys, bang = true })
  end, { silent = true })
end

-- navigation - buffers
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Goto Previous Buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Goto Next Buffer" })
vim.keymap.set("n", "<C-left>", "<cmd>bprev<CR>", { desc = "Goto Previous Buffer" })
vim.keymap.set("n", "<C-right>", "<cmd>bnext<CR>", { desc = "Goto Next Buffer" })

-- navigation - code: ]m / [m live in plugins/treesitter.lua

-- quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>", { desc = "Previous Quickfix Item" })

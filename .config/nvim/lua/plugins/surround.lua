return {
    'tpope/vim-surround',
    config = function()
        vim.keymap.set("n", "s", "<Plug>VSurround", { noremap = false })
        vim.keymap.set("n", "S", "<Plug>VSurround", { noremap = false })
        vim.keymap.set("n", "ds", "<Plug>Dsurround", { noremap = false })
        vim.keymap.set("n", "cs", "<Plug>Csurround", { noremap = false })
        vim.keymap.set("n", "ys", "<Plug>Ysurround", { noremap = false })
        vim.keymap.set("n", "yS", "<Plug>Ysurround", { noremap = false })
    end
}


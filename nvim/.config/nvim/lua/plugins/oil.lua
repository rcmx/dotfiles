return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "echasnovski/mini.icons" },
    -- oil recommends against lazy loading
    lazy = false,
    keys = {
        { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
}

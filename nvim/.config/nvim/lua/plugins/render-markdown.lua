return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    keys = {
        { "<leader>um", function() require("render-markdown").toggle() end, ft = "markdown", desc = "Toggle Markdown Render" },
    },
}

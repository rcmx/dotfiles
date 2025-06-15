return {
    "seblj/roslyn.nvim",
    dependencies = { "williamboman/mason.nvim" },
    ft = "cs",
    opts = {
        -- your configuration comes here; leave empty for default settings
    },
    config = function()
        local roslyn = require("roslyn")
        roslyn.setup({})
    end
}

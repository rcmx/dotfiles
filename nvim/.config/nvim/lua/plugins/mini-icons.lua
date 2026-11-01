-- icon provider shared by oil, lualine, diffview and render-markdown
return {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
        -- plugins that only know nvim-web-devicons get mini.icons instead
        package.preload["nvim-web-devicons"] = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
}

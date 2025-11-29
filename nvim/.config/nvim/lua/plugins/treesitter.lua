return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.install'.prefer_git = false
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "c_sharp",
                "dockerfile",
                "editorconfig",
                "javascript",
                "json",
                "json5",
                "lua",
                "html",
                "markdown",
                "markdown_inline",
                "powershell",
                "typescript",
                "svelte",
                "tmux",
                "vim",
                "xml",
                "yaml"
            },
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}

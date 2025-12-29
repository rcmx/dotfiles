return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    -- config = function() {
    --     install {
    --         'c_sharp'
    --     }
        -- require 'nvim-treesitter'.install {
        -- require 'nvim-treesitter'.install {
        -- }
    -- }
        -- require 'nvim-treesitter.install{
        -- k.prefer_git = false
        -- local config = require("nvim-treesitter.configs")
        -- config.setup({
        --     ensure_installed = {
        --         "c_sharp",
        --         "dockerfile",
        --         "editorconfig",
        --         "javascript",
        --         "json",
        --         "json5",
        --         "lua",
        --         "html",
        --         "markdown",
        --         "markdown_inline",
        --         "powershell",
        --         "typescript",
        --         "svelte",
        --         "tmux",
        --         "vim",
        --         "xml",
        --         "yaml"
        --     },
        --     highlight = { enable = true },
        --     indent = { enable = true }
        -- })
    -- end
}

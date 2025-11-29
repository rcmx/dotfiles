return {
    'nvim-lualine/lualine.nvim',
    enabled = not vim.g.vscode,

    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        require('lualine').setup()
    end
}


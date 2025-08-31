return {
  'oribarilan/lensline.nvim',
  branch = 'release/1.x', -- or: branch = 'release/1.x' for latest non-breaking updates
  event = 'LspAttach',
  config = function()
    require("lensline").setup()
  end,
}


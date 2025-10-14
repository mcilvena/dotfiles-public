return {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      width = 100,
    },
    on_open = function(win)
      vim.opt.colorcolumn = ''
      vim.opt.linebreak = true
    end,
    on_close = function() end,
  },
}

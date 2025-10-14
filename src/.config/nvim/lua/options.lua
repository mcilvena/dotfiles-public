-- Set leader
vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartcase = true

-- In init.lua
vim.opt.clipboard = 'unnamedplus'

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch', -- Highlight group to use
      timeout = 200, -- Duration of the highlight in milliseconds
    }
  end,
})

-- Undo
vim.opt.undofile = true
local undodir = vim.fn.stdpath 'data' .. '/undo'
vim.opt.undodir = undodir
if not vim.fn.isdirectory(undodir) then
  vim.fn.mkdir(undodir, 'p')
end
vim.opt.undolevels = 50

-- Character limits
vim.opt.colorcolumn = '100'

-- Disable splash screen
vim.opt.shortmess:append 'I'

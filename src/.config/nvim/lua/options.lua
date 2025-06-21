-- Set leader
vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true

-- In init.lua
vim.opt.clipboard = 'unnamedplus'
-- vim.g.clipboard = {
--   name = 'WslClipboard',
--   copy = {
--     ['+'] = 'clip.exe',
--     ['*'] = 'clip.exe',
--   },
--   paste = {
--     ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--   },
--   cache_enabled = 0,
-- }

-- Folding (handled by nvim-ufo plugin)
-- vim.opt.foldenable = true
-- vim.opt.foldlevelstart = 1
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldminlines = 2

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch', -- Highlight group to use
      timeout = 200,         -- Duration of the highlight in milliseconds
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

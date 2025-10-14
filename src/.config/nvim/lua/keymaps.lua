-- Keymaps configuration file
-- This file defines custom keybindings for Neovim to enhance productivity and workflow.

local map = vim.keymap.set
-- Utility function for filetype-specific keymaps
local function map_ft(filetypes, mode, lhs, rhs, opts)
  opts = opts or {}

  -- Ensure filetypes is a table
  if type(filetypes) == 'string' then
    filetypes = { filetypes }
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function(event)
      local buffer_opts = vim.tbl_extend('force', opts, { buffer = event.buf })
      vim.keymap.set(mode, lhs, rhs, buffer_opts)
    end,
  })
end

-- Reload config
map('n', '<leader>rr', function()
  vim.cmd 'source %'
  print 'Reloaded config'
end, { desc = '[R]eload [R]config' })

------------------------------------------------------------------------------------------
-- General Keymaps
------------------------------------------------------------------------------------------

-- Save file
map('n', '<C-s>', ':w<CR>', { desc = '[S]ave file' })
-- Copy current word
map('n', '<C-c>', 'yiw', { desc = 'Copy current word' })
-- Copy selection
map('v', '<C-c>', '"+y', { desc = 'Copy selection' })
-- Clear selection/search highlight
map('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })
-- Quick quit with q
map('n', 'Q', ':q<CR>', { desc = 'Quit' })
map('n', 'W', ':w<CR>', { desc = 'Quit' })

------------------------------------------------------------------------------------------
-- Buffer Management
------------------------------------------------------------------------------------------

-- Delete buffer
map('n', '<leader>bd', ':bd<CR>', { desc = '[B]uffer [D]elete' })
map('n', '<leader>x', ':bd<CR>', { desc = '[B]uffer [D]elete' })
-- Next buffer
map('n', '<leader>bn', ':bn<CR>', { desc = '[B]uffer [N]ext' })
-- Previous buffer
map('n', '<leader>bp', ':bp<CR>', { desc = '[B]uffer [P]revious' })
-- Close all buffers
map('n', '<leader>ba', ':%bd<CR>', { desc = '[B]uffer close [A]ll' })

------------------------------------------------------------------------------------------
-- Window Management
------------------------------------------------------------------------------------------

-- Window horizontal split
map('n', '<leader>wh', ':split<CR>', { desc = '[W]indow [H]orizontal split' })
-- Vertical window split
map('n', '<leader>wv', ':vsplit<CR>', { desc = '[W]indow [V]ertical split' })
-- Close window
map('n', '<leader>wc', ':close<CR>', { desc = '[W]indow [C]lose' })
-- Only window (close others)
map('n', '<leader>wo', ':only<CR>', { desc = '[W]indow [O]nly' })
-- Move to left window
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
-- Move to right window
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
-- Move to below window
map('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
-- Move to above window
map('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })

------------------------------------------------------------------------------------------
-- Move Lines
------------------------------------------------------------------------------------------

-- Normal mode: Move current line up
map('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
map('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
-- Visual mode: Move selected lines up
map('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Normal mode: Move current line down
map('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
map('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
-- Visual mode: Move selected lines down
map('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

------------------------------------------------------------------------------------------
-- Markdown Specific Keymaps
------------------------------------------------------------------------------------------

map_ft('markdown', 'n', '<C-t>', 'o- [ ] ', { desc = 'Insert [T]odo item' })
map_ft('markdown', 'i', '<C-t>', '<ESC>o- [ ] ', { desc = 'Insert [T]odo item' })
map_ft('markdown', 'n', '<M-A-t>', 'o- [ ] ', { desc = 'Insert [T]odo item' })
map_ft('markdown', 'i', '<M-A-t>', '<ESC>o- [ ] ', { desc = 'Insert [T]odo item' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    map('n', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local pos = vim.api.nvim_win_get_cursor(0)

      -- Check if the current line contains any checkbox
      if line:match '^%s*- %[[ x]%]' then
        local new_line
        -- If unchecked, check it and add timestamp
        if line:match '^%s*- %[ %]' then
          local timestamp = os.date '[done: %I:%M%p - %a %d %b %Y]'
          -- Remove any existing timestamp if present
          line = line:gsub('%[done: .*%]', ''):gsub('%s+$', '')
          new_line = line:gsub('- %[ %]', '- [x]') .. ' ' .. timestamp
        else
          -- If checked, uncheck it and remove timestamp
          new_line = line:gsub('%[done: .*%]', '') -- Remove timestamp
          new_line = new_line:gsub('- %[x%]', '- [ ]') -- Replace checkbox
          new_line = new_line:gsub('%s+$', '') -- Remove trailing whitespace
        end
        vim.api.nvim_set_current_line(new_line)
        -- Keep cursor position
        vim.api.nvim_win_set_cursor(0, pos)
      else
        -- Normal Enter behavior if not on a checkbox line
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
      end
    end, { buffer = true, silent = true })
  end,
})

------------------------------------------------------------------------------------------
-- Folding Keymaps
------------------------------------------------------------------------------------------

-- Single key fold toggle
map('n', '<Tab>', 'za', { noremap = true, silent = true, desc = 'Toggle fold' })

-- Simple fold navigation
map('n', 'zj', 'zjzz', { noremap = true, silent = true, desc = 'Move to next fold' })
map('n', 'zk', 'zkzz', { noremap = true, silent = true, desc = 'Move to previous fold' })
map('n', 'zh', 'zc', { noremap = true, silent = true, desc = 'Close fold' })
map('n', 'zl', 'zo', { noremap = true, silent = true, desc = 'Open fold' })

-- Quick fold level adjustment
map('n', 'z1', ':set foldlevel=0<CR>', { noremap = true, silent = true, desc = 'Set fold level to 0' })
map('n', 'z2', ':set foldlevel=1<CR>', { noremap = true, silent = true, desc = 'Set fold level to 1' })
map('n', 'z3', ':set foldlevel=2<CR>', { noremap = true, silent = true, desc = 'Set fold level to 2' })
map('n', 'z4', ':set foldlevel=3<CR>', { noremap = true, silent = true, desc = 'Set fold level to 3' })
map('n', 'z5', ':set foldlevel=4<CR>', { noremap = true, silent = true, desc = 'Set fold level to 4' })
map('n', 'z0', ':set foldlevel=99<CR>', { noremap = true, silent = true, desc = 'Open all folds' })

------------------------------------------------------------------------------------------
-- AI Workflow Hub - CodeCompanion Keymaps
------------------------------------------------------------------------------------------

-- Primary AI interface
map({ 'n', 'v' }, '<leader>aa', ':CodeCompanionActions<cr>', { desc = '[A]I [A]ctions menu' })
map({ 'n', 'v' }, '<leader>ac', ':CodeCompanionChat Toggle<cr>', { desc = '[A]I [C]hat toggle' })
map('v', '<leader>ae', ':CodeCompanionChat Add<cr>', { desc = '[A]I [E]xplain code' })

-- Quick AI actions
map({ 'n', 'v' }, '<leader>ai', ':CodeCompanion improve code<cr>', { desc = '[A]I [I]mprove code' })
map({ 'n', 'v' }, '<leader>ad', ':CodeCompanion documentation<cr>', { desc = '[A]I [D]ocumentation' })
map({ 'n', 'v' }, '<leader>at', ':CodeCompanion tests<cr>', { desc = '[A]I [T]ests generate' })

-- AI context management
map('n', '<leader>af', ':CodeCompanionChat Add<cr>', { desc = '[A]I [F]iles add to context' })
map('n', '<leader>ar', ':CodeCompanionChat Reset<cr>', { desc = '[A]I [R]eset context' })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]

------------------------------------------------------------------------------------------
-- Search & Navigation - Telescope Keymaps
------------------------------------------------------------------------------------------

-- Moved to telescope.lua as <leader>sd for consistency
map('n', '<leader>fw', function()
  local word = vim.fn.expand '<cword>'
  local cmd = 'cexpr system(\'rg -i "' .. word .. '" --vimgrep\')'
  vim.cmd(cmd)
  vim.cmd 'copen'
  vim.api.nvim_echo({ { 'Searching for "' .. word .. '" (case insensitive) with ripgrep', 'Normal' } }, false, {})
end, { desc = 'Find word under cursor with ripgrep (case insensitive)' })

------------------------------------------------------------------------------------------
-- Floating Terminal Commands
------------------------------------------------------------------------------------------

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

local function _lazygit_toggle()
  lazygit:toggle()
end

map('n', '<leader>g', _lazygit_toggle, { desc = '[G]it lazygit toggle' })

local float_terminal = Terminal:new { direction = 'float', hidden = true }

local function _float_terminal_toggle()
  float_terminal:toggle()
end

map('n', '<leader>tt', _float_terminal_toggle, { desc = '[T]erminal [T]oggle' })

------------------------------------------------------------------------------------------
-- Zen Mode
------------------------------------------------------------------------------------------

map('n', 'Z', function()
  require('zen-mode').toggle()
end, { desc = '[Z]en Mode' })

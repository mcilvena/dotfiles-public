-- Keymaps configuration file
-- This file defines custom keybindings for Neovim to enhance productivity and workflow.

-- Reload config
vim.keymap.set('n', '<leader>rr', function()
  vim.cmd 'source %'
  print 'Reloaded config'
end, { desc = '[R]eload [R]config' })

------------------------------------------------------------------------------------------
-- General Keymaps
------------------------------------------------------------------------------------------

-- Save file
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = '[S]ave file' })
-- Copy current word
vim.keymap.set('n', '<C-c>', 'yiw', { desc = 'Copy current word' })
-- Copy selection
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy selection' })
-- Clear selection/search highlight
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlight' })

------------------------------------------------------------------------------------------
-- Buffer Management
------------------------------------------------------------------------------------------

-- Delete buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>x', '<cmd>bd<CR>', { desc = '[B]uffer [D]elete' })
-- Next buffer
vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>', { desc = '[B]uffer [N]ext' })
-- Previous buffer
vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>', { desc = '[B]uffer [P]revious' })
-- Close all buffers
vim.keymap.set('n', '<leader>ba', '<cmd>%bd<CR>', { desc = '[B]uffer close [A]ll' })

------------------------------------------------------------------------------------------
-- Window Management
------------------------------------------------------------------------------------------

-- Window horizontal split
vim.keymap.set('n', '<leader>wh', '<cmd>split<CR>', { desc = '[W]indow [H]orizontal split' })
-- Vertical window split
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = '[W]indow [V]ertical split' })
-- Close window
vim.keymap.set('n', '<leader>wc', '<cmd>close<CR>', { desc = '[W]indow [C]lose' })
-- Only window (close others)
vim.keymap.set('n', '<leader>wo', '<cmd>only<CR>', { desc = '[W]indow [O]nly' })
-- Move to left window
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
-- Move to right window
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
-- Move to below window
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
-- Move to above window
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })

------------------------------------------------------------------------------------------
-- Move Lines
------------------------------------------------------------------------------------------

-- Normal mode: Move current line up
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
-- Visual mode: Move selected lines up
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Normal mode: Move current line down
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
-- Visual mode: Move selected lines down
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

------------------------------------------------------------------------------------------
-- Markdown Specific Keymaps
------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local pos = vim.api.nvim_win_get_cursor(0)

      -- Check if the current line contains any checkbox
      if line:match '^%s*- %[[ X]%]' then
        local new_line
        -- If unchecked, check it and add timestamp
        if line:match '^%s*- %[ %]' then
          local timestamp = os.date '[done: %I:%M%p - %a %d %b %Y]'
          -- Remove any existing timestamp if present
          line = line:gsub('%[done: .*%]', ''):gsub('%s+$', '')
          new_line = line:gsub('- %[ %]', '- [X]') .. ' ' .. timestamp
        else
          -- If checked, uncheck it and remove timestamp
          new_line = line:gsub('%[done: .*%]', '')     -- Remove timestamp
          new_line = new_line:gsub('- %[X%]', '- [ ]') -- Replace checkbox
          new_line = new_line:gsub('%s+$', '')         -- Remove trailing whitespace
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
vim.keymap.set('n', '<Tab>', 'za', { noremap = true, silent = true, desc = 'Toggle fold' })

-- Simple fold navigation
vim.keymap.set('n', 'zj', 'zjzz', { noremap = true, silent = true, desc = 'Move to next fold' })
vim.keymap.set('n', 'zk', 'zkzz', { noremap = true, silent = true, desc = 'Move to previous fold' })
vim.keymap.set('n', 'zh', 'zc', { noremap = true, silent = true, desc = 'Close fold' })
vim.keymap.set('n', 'zl', 'zo', { noremap = true, silent = true, desc = 'Open fold' })

-- Quick fold level adjustment
vim.keymap.set('n', 'z1', ':set foldlevel=0<CR>', { noremap = true, silent = true, desc = 'Set fold level to 0' })
vim.keymap.set('n', 'z2', ':set foldlevel=1<CR>', { noremap = true, silent = true, desc = 'Set fold level to 1' })
vim.keymap.set('n', 'z3', ':set foldlevel=2<CR>', { noremap = true, silent = true, desc = 'Set fold level to 2' })
vim.keymap.set('n', 'z4', ':set foldlevel=3<CR>', { noremap = true, silent = true, desc = 'Set fold level to 3' })
vim.keymap.set('n', 'z5', ':set foldlevel=4<CR>', { noremap = true, silent = true, desc = 'Set fold level to 4' })
vim.keymap.set('n', 'z0', ':set foldlevel=99<CR>', { noremap = true, silent = true, desc = 'Open all folds' })

------------------------------------------------------------------------------------------
-- AI Workflow Hub - CodeCompanion Keymaps
------------------------------------------------------------------------------------------

-- Primary AI interface
vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = '[A]I [A]ctions menu' })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[A]I [C]hat toggle' })
vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanionChat Add<cr>', { desc = '[A]I [E]xplain code' })

-- Quick AI actions
vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion improve code<cr>', { desc = '[A]I [I]mprove code' })
vim.keymap.set({ 'n', 'v' }, '<leader>ad', '<cmd>CodeCompanion documentation<cr>', { desc = '[A]I [D]ocumentation' })
vim.keymap.set({ 'n', 'v' }, '<leader>at', '<cmd>CodeCompanion tests<cr>', { desc = '[A]I [T]ests generate' })

-- AI context management
vim.keymap.set('n', '<leader>af', '<cmd>CodeCompanionChat Add<cr>', { desc = '[A]I [F]iles add to context' })
vim.keymap.set('n', '<leader>ar', '<cmd>CodeCompanionChat Reset<cr>', { desc = '[A]I [R]eset context' })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]

------------------------------------------------------------------------------------------
-- Search & Navigation - Telescope Keymaps
------------------------------------------------------------------------------------------

-- Moved to telescope.lua as <leader>sd for consistency
vim.keymap.set('n', '<leader>fw', function()
  local word = vim.fn.expand('<cword>')
  local cmd = 'cexpr system(\'rg -i "' .. word .. '" --vimgrep\')'
  vim.cmd(cmd)
  vim.cmd('copen')
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

vim.keymap.set('n', '<leader>g', _lazygit_toggle, { desc = '[G]it lazygit toggle' })

local float_terminal = Terminal:new { direction = 'float', hidden = true }

local function _float_terminal_toggle()
  float_terminal:toggle()
end

vim.keymap.set('n', '<leader>tt', _float_terminal_toggle, { desc = '[T]erminal [T]oggle' })

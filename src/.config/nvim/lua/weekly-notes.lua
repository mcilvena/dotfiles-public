-- lua/weekly-notes.lua
local M = {}

-- Function to get Monday of current week
local function get_monday_date()
  local current_time = os.time()
  local current_date = os.date('*t', current_time)

  -- Get current day of week (1=Sunday, 2=Monday, ..., 7=Saturday)
  local current_weekday = current_date.wday

  -- Calculate days to subtract to get to Monday
  local days_to_monday
  if current_weekday == 1 then -- Sunday
    days_to_monday = 6
  else -- Monday=1, Tuesday=2, etc.
    days_to_monday = current_weekday - 2
  end

  -- Calculate Monday's timestamp
  local monday_time = current_time - (days_to_monday * 24 * 60 * 60)

  return monday_time
end

-- Function to create weekly note
local function create_weekly_note()
  local monday_time = get_monday_date()
  local date = os.date('%Y-%m-%d', monday_time)
  local day_name = os.date('%A, %d %B %Y', monday_time)
  local filename = 'weekly/' .. date .. '.md'

  -- Check if file already exists
  if vim.fn.filereadable(filename) == 1 then
    vim.cmd('edit ' .. filename)
    return
  end

  -- Read template
  local template_file = 'weekly/.template.md'
  local template_content = {}

  if vim.fn.filereadable(template_file) == 1 then
    for line in io.lines(template_file) do
      -- Replace the <TITLE> placeholder with actual date
      local processed_line = line:gsub('<TITLE>', day_name)
      table.insert(template_content, processed_line)
    end
  else
    -- Fallback if template doesn't exist
    print('Template file not found: ' .. template_file)
    return
  end

  -- Create the file with content
  vim.cmd('edit ' .. filename)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, template_content)
  vim.cmd 'write'
  print('Created weekly note for Monday ' .. date .. ': ' .. filename)
end

-- Function to navigate to previous/next week's note
local function navigate_week(offset)
  local current_file = vim.fn.expand '%:t:r' -- Get filename without extension
  local current_path = vim.fn.expand '%:h' -- Get directory path

  -- Parse the date from current filename (YYYY-MM-DD format)
  local year, month, day = current_file:match '(%d%d%d%d)-(%d%d)-(%d%d)'

  if not year then
    print 'Not in a weekly note file'
    return
  end

  -- Convert to timestamp
  local current_time = os.time {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = 12,
  }

  -- Add/subtract 7 days
  local target_time = current_time + (offset * 7 * 24 * 60 * 60)
  local target_date = os.date('%Y-%m-%d', target_time)
  local target_file = current_path .. '/' .. target_date .. '.md'

  -- Check if file exists
  if vim.fn.filereadable(target_file) == 1 then
    vim.cmd('edit ' .. target_file)
  else
    local direction = offset > 0 and 'next' or 'previous'
    print('No ' .. direction .. ' week note found: ' .. target_date .. '.md')
  end
end

-- Setup buffer-local keymaps for weekly notes navigation
local function setup_weekly_navigation()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = '*/weekly/*.md',
    callback = function(event)
      local bufnr = event.buf

      -- Map Ctrl+p for previous week
      vim.keymap.set('n', '<leader>p', function()
        navigate_week(-1)
      end, {
        desc = 'Previous week note',
        buffer = bufnr,
      })

      -- Map Ctrl+n for next week
      vim.keymap.set('n', '<leader>n', function()
        navigate_week(1)
      end, {
        desc = 'Next week note',
        buffer = bufnr,
      })
    end,
  })
end

-- Function to setup keymaps conditionally
local function setup_conditional_keymap(keymap)
  -- Create an autocommand that runs when entering a directory
  vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    callback = function()
      -- Check if template file exists in current directory
      if vim.fn.filereadable 'weekly/.template.md' == 1 then
        -- Create keymap if template exists
        vim.keymap.set('n', keymap, '<cmd>WeeklyNote<cr>', {
          desc = 'Create/open weekly note',
          buffer = false, -- Global keymap
        })
      else
        -- Remove keymap if template doesn't exist
        pcall(vim.keymap.del, 'n', keymap)
      end
    end,
  })
end

--[[
Weekly Notes Setup

Basic usage:
  require('weekly-notes').setup()

With conditional keyboard shortcut:
  require('weekly-notes').setup({
    keymap = '<leader>wn'  -- Only active in projects with weekly/.template.md
  })

Creates files named after Monday of current week (e.g., 2025-08-18.md)
Keymap automatically activates/deactivates when changing directories
Use <TITLE> placeholder in template for auto date replacement
--]]
-- Setup function to create commands and keymaps
function M.setup(opts)
  opts = opts or {}

  -- Always create the command
  vim.api.nvim_create_user_command('WeeklyNote', create_weekly_note, {})

  -- Conditionally add keymap based on template file presence
  if opts.keymap then
    setup_conditional_keymap(opts.keymap)
  end

  -- Always setup weekly navigation keymaps
  setup_weekly_navigation()
end

-- Expose the function for direct use if needed
M.create_weekly_note = create_weekly_note
M.navigate_week = navigate_week

return M

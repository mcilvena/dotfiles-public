-- File explorer that lets you edit your filesystem like a buffer
-- Provides a modern alternative to netrw with floating windows and preview
return {
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      float = {
        padding = 2,
        max_width = 0.8,
        max_height = 0.8,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        preview_split = 'right',
      },
      preview_win = {
        update_on_cursor_moved = true,
        preview_method = 'fast_scratch',
        win_options = {},
      },
      view_options = {
        show_hidden = true,
        skip_confirm_for_simple_edits = true,
      },
      columns = { 'icon', 'permissions' },
      keymaps = {
        ['q'] = 'actions.close',
      },
    },
    dependencies = {
      { 'echasnovski/mini.icons', opts = {} },
    },
    keys = {
      { '-', '<cmd>Oil --float --preview<CR>', { desc = 'Open parent directory with preview' } },
    },
  },
}

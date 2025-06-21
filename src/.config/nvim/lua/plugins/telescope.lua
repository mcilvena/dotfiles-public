-- Fuzzy finder and picker for files, buffers, LSP symbols, and more
-- Highly configurable with multiple extensions for enhanced functionality
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'smartpde/telescope-recent-files',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup {
      pickers = {
        find_files = {
          hidden = true,
          file_ignore_patterns = { '.git/', 'node_modules/', 'target/' },
        },
      },
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--hidden',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--glob', '!.git/*',
        },
        path_display = { 'truncate' },
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
          vertical = {
            preview_height = 0.5,
          },
        },
      },
      extensions = {
        fzf = {},
        ['ui-select'] = require('telescope.themes').get_dropdown {},
      },
    }
    telescope.load_extension('fzf')
    telescope.load_extension('recent_files')
    telescope.load_extension('ui-select')

    -- keymaps
    vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader><leader>', require('telescope').extensions.recent_files.pick, { desc = '[S]earch [R]ecent files' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', function()
      require('telescope.builtin').live_grep({
        additional_args = function()
          return { "--hidden" }
        end,
      })
    end, { desc = 'Fuzzy [S]earch (live_[g]rep)' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp tags' })
    vim.keymap.set('n', '<leader>sb', require('telescope.builtin').builtin, { desc = 'Telescope [B]uiltins' })
    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols,
      { desc = '[S]earch [S]ymbols document' })
    vim.keymap.set('n', '<leader>sS', require('telescope.builtin').lsp_workspace_symbols,
      { desc = '[S]earch [S]ymbols workspace' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references,
      { desc = '[S]earch [R]eferences' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
      { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sn', function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath('config'),
        prompt_title = "Neovim Config",
        hidden = true,
      }
    end, { desc = '[S]earch [N]eovim config' })
    vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
  end,
}

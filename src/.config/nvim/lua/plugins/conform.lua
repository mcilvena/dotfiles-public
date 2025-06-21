-- Code formatting plugin with support for multiple formatters per filetype
-- Automatically formats code on save and provides manual formatting commands
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[C]ode [F]ormat',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      javascript = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      html = { 'prettierd', 'prettier' },
      css = { 'prettierd', 'prettier' },
      json = { 'prettierd', 'prettier' },
      yaml = { 'prettierd', 'prettier' },
      markdown = { 'prettierd', 'prettier' },
      bash = { 'shfmt' },
      toml = { 'taplo' },
    },
  },
}

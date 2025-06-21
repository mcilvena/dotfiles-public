-- Language Server Protocol configuration with Mason for server management
-- Provides intelligent code completion, diagnostics, and language-specific features
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'nvim-telescope/telescope.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('mason').setup()

      local lsp = require 'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      lsp.bashls.setup { capabilities = capabilities }
      lsp.jsonls.setup { capabilities = capabilities }
      lsp.yamlls.setup { capabilities = capabilities }
      lsp.ts_ls.setup { capabilities = capabilities }
      lsp.taplo.setup { capabilities = capabilities }
      lsp.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      }
      lsp.rust_analyzer.setup {
        capabilities = capabilities,
        cmd = { '/home/mcilvena/.cargo/bin/rust-analyzer' }, -- Use system rust-analyzer to prevent duplication
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              buildScripts = {
                enable = false, -- Prevent running build scripts unnecessarily
              },
            },
          },
        },
      }

      -- Disable LSP formatting since conform.nvim handles it
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      })

      -- Keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [D]efinition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]o to [D]eclaration' })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]o to [R]eferences' })
      vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { desc = '[G]o to [I]mplementation' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
      vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, { desc = '[C]ode [E]rror float' })
      vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = '[C]ode [Q]uickfix list' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ctions' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = '[C]ode [R]ename' })
    end,
  },
}

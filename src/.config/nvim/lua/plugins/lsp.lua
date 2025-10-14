-- Language Server Protocol configuration with Mason for server management
-- Provides intelligent code completion, diagnostics, and language-specific features
-- Uses native Neovim 0.11+ vim.lsp.config API (no nvim-lspconfig plugin needed)
return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('mason').setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      vim.lsp.config.bashls = {
        capabilities = capabilities,
        filetypes = { 'sh', 'bash' },
      }
      vim.lsp.config.hyprls = {
        capabilities = capabilities,
        filetypes = { 'hyprlang' },
      }
      vim.lsp.config.jsonls = {
        capabilities = capabilities,
        filetypes = { 'json', 'jsonc' },
      }
      vim.lsp.config.yamlls = {
        capabilities = capabilities,
        filetypes = { 'yaml', 'yaml.docker-compose' },
        settings = {
          yaml = {
            completion = true,
            schemas = {
              [vim.fn.stdpath 'config' .. '/schemas/cloudformation-template-schema.json'] = {
                '*.cf.yaml',
                'template.yaml',
              },
            },
            customTags = {
              '!Base64',
              '!Cidr',
              '!FindInMap sequence',
              '!GetAtt',
              '!GetAZs',
              '!ImportValue',
              '!Join sequence',
              '!Ref',
              '!Select sequence',
              '!Split sequence',
              '!Sub sequence',
              '!Sub',
              '!And sequence',
              '!Condition',
              '!Equals sequence',
              '!If sequence',
              '!Not sequence',
              '!Or sequence',
            },
          },
        },
      }
      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      }
      vim.lsp.config.tailwindcss = {
        capabilities = capabilities,
        filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
      }
      vim.lsp.config.eslint = {
        capabilities = capabilities,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      }
      vim.lsp.config.taplo = {
        capabilities = capabilities,
        filetypes = { 'toml' },
      }
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        filetypes = { 'lua' },
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      }
      vim.lsp.config.rust_analyzer = {
        capabilities = capabilities,
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              buildScripts = {
                enable = false,
              },
            },
          },
        },
      }
      vim.lsp.config.marksman = {
        capabilities = capabilities,
        filetypes = { 'markdown', 'markdown.mdx' },
      }
      vim.lsp.config.clangd = {
        capabilities = capabilities,
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        single_file_support = true,
      }

      -- Enable configured servers (they will auto-start based on filetypes)
      vim.lsp.enable { 'bashls', 'hyprls', 'jsonls', 'yamlls', 'ts_ls', 'tailwindcss', 'eslint', 'taplo', 'lua_ls', 'rust_analyzer', 'marksman', 'clangd' }

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

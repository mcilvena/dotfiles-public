-- Completion engine plugin - provides intelligent autocomplete suggestions
-- Uses blink.cmp for fast, modern completion with LSP, snippets, buffer, and path sources
return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = { codecompanion = { 'codecompanion' } },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  -- Alternative completion plugin (nvim-cmp) - commented out in favor of blink.cmp
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-vsnip',
  --     'hrsh7th/vim-vsnip',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'rafamadriz/friendly-snippets',
  --   },
  --   config = function()
  --     local cmp = require 'cmp'
  --
  --     vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
  --
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local feedkey = function(key, mode)
  --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  --     end
  --
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           vim.fn['vsnip#anonymous'](args.body)
  --         end,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered {
  --           max_height = 15,
  --           max_width = 60,
  --         },
  --       },
  --       mapping = cmp.mapping.preset.insert {
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-e>'] = cmp.mapping.abort(),
  --         ['<C-y>'] = cmp.mapping.confirm { select = true },
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif vim.fn["vsnip#available"](1) == 1 then
  --             feedkey("<Plug>(vsnip-expand-or-jump)", "")
  --           elseif has_words_before() then
  --             cmp.complete()
  --           else
  --             fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  --           end
  --         end, { "i", "s" }),
  --
  --         ["<S-Tab>"] = cmp.mapping(function()
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif vim.fn["vsnip#jumpable"](-1) == 1 then
  --             feedkey("<Plug>(vsnip-jump-prev)", "")
  --           end
  --         end, { "i", "s" }),
  --       },
  --       sources = cmp.config.sources {
  --         { name = 'nvim_lsp' },
  --         { name = 'vsnip' },
  --         { name = 'buffer' },
  --         { name = 'path' },
  --         { name = 'crates' },
  --       },
  --       formatting = {
  --         format = function(entry, vim_item)
  --           vim_item.menu = ({
  --             nvim_lsp = '[LSP]',
  --             vsnip = '[Snippet]',
  --             buffer = '[Buffer]',
  --             path = '[Path]',
  --           })[entry.source.name]
  --           return vim_item
  --         end,
  --       },
  --     }
  --   end,
  -- }
}

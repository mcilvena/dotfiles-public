-- Colorscheme plugins for theming Neovim
-- Includes huez for colorscheme management, catppuccin as primary theme, and tokyonight as backup
return {
  {
    -- Colorscheme manager for easy theme switching
    'vague2k/huez.nvim',
    -- if you want registry related features, uncomment this
    -- import = "huez-manager.import"
    branch = 'stable',
    event = 'UIEnter',
    config = function()
      require('huez').setup {}
    end,
  },
  {
    -- Primary colorscheme with warm, pastel colors and extensive plugin integrations
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
        },
        -- custom_highlights = function(colors)
        --   return {
        --     Normal = { bg = "#111111" },
        --     NormalNC = { bg = "#111111" },
        --     SignColumn = { bg = "#111111" },
        --     EndOfBuffer = { bg = "#111111" },
        --   }
        -- end,
      }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    -- Alternative dark colorscheme with Tokyo night theme
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
}

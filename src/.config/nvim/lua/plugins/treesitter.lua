-- Syntax highlighting and parsing with treesitter
-- Provides better syntax highlighting, indentation, and code understanding
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'javascript', 'html', 'json', 'yaml', 'rust', 'markdown', 'toml' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },
}

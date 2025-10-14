-- Enhanced Tailwind CSS support with color previews and better IntelliSense
-- Provides conceal classes, color decorations, and improved completions for Tailwind
return {
  'luckasRanarison/tailwind-tools.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    document_color = {
      enabled = true,
      kind = "foreground",
      inline_symbol = "󰝤 ",
      debounce = 200,
    },
    conceal = {
      enabled = false,
      min_length = nil,
      symbol = "󱏿",
      highlight = {
        fg = "#38BDF8",
      },
    },
    custom_filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "astro",
      "html",
    },
  },
}
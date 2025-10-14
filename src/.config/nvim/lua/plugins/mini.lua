-- Collection of minimal, independent Neovim modules
-- Includes icons, auto-pairs, custom statusline, and session management
return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup()
      require('mini.pairs').setup()
      require('mini.statusline').setup {
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 75 }

            -- Custom filetype section with icon and name only
            local filetype = vim.bo.filetype
            local icon = MiniIcons.get('filetype', filetype)
            local filetype_section = filetype == '' and '' or (icon .. ' ' .. filetype)

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git } },
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- Right align
              { strings = { lsp } },
              { hl = 'MiniStatuslineFilename', strings = { filetype_section } },
            }
          end,
        },
      }
      require('mini.sessions').setup {
        autoread = true,
        autowrite = true,
      }
    end,
  },
}

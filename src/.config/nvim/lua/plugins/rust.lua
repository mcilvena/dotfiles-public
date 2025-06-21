-- Rust development tools and crate management
-- Provides enhanced Cargo.toml editing with version management and crate information
return {
  {
    'saecki/crates.nvim',
    tag = 'stable',
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)

      local opts = { silent = true }

      vim.keymap.set('n', '<leader>Rt', crates.toggle, { desc = '[R]ust crates [T]oggle', silent = true })
      vim.keymap.set('n', '<leader>Rr', crates.reload, { desc = '[R]ust crates [R]eload', silent = true })

      vim.keymap.set('n', '<leader>Rv', crates.show_versions_popup, { desc = '[R]ust crates [V]ersions', silent = true })
      vim.keymap.set('n', '<leader>Rf', crates.show_features_popup, { desc = '[R]ust crates [F]eatures', silent = true })
      vim.keymap.set('n', '<leader>Rd', crates.show_dependencies_popup, { desc = '[R]ust crates [D]ependencies', silent = true })

      vim.keymap.set('n', '<leader>Ru', crates.update_crate, { desc = '[R]ust crates [U]pdate', silent = true })
      vim.keymap.set('v', '<leader>Ru', crates.update_crates, { desc = '[R]ust crates [U]pdate selected', silent = true })
      vim.keymap.set('n', '<leader>RU', crates.upgrade_crate, { desc = '[R]ust crates [U]pgrade', silent = true })
      vim.keymap.set('v', '<leader>RU', crates.upgrade_crates, { desc = '[R]ust crates [U]pgrade selected', silent = true })
      vim.keymap.set('n', '<leader>RA', crates.upgrade_all_crates, { desc = '[R]ust crates upgrade [A]ll', silent = true })

      vim.keymap.set('n', '<leader>Rx', crates.expand_plain_crate_to_inline_table, { desc = '[R]ust crates e[X]pand', silent = true })
      vim.keymap.set('n', '<leader>RX', crates.extract_crate_into_table, { desc = '[R]ust crates e[X]tract', silent = true })

      vim.keymap.set('n', '<leader>RH', crates.open_homepage, { desc = '[R]ust crates [H]omepage', silent = true })
      vim.keymap.set('n', '<leader>RR', crates.open_repository, { desc = '[R]ust crates [R]epository', silent = true })
      vim.keymap.set('n', '<leader>RD', crates.open_documentation, { desc = '[R]ust crates [D]ocs', silent = true })
      vim.keymap.set('n', '<leader>RC', crates.open_crates_io, { desc = '[R]ust [C]rates.io', silent = true })
      vim.keymap.set('n', '<leader>RL', crates.open_lib_rs, { desc = '[R]ust [L]ib.rs', silent = true })
    end,
  },
}

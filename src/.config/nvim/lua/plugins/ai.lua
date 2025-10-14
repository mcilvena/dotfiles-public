-- AI assistant plugin for code generation and chat interactions
-- Supports multiple AI providers (Anthropic, Gemini, Ollama) with environment variable configuration
return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- Get adapter from environment variable or fall back to default
      local function get_adapter_from_env()
        local env_adapter = vim.fn.getenv("CODECOMPANION_ADAPTER")
        if env_adapter ~= vim.NIL and env_adapter ~= "" then
          return env_adapter
        end
        return "anthropic" -- Default adapter
      end

      -- Get model for specific adapter from environment variable or fall back to default
      local function get_model_from_env(adapter, default_model)
        local env_var = "CODECOMPANION_" .. string.upper(adapter) .. "_MODEL"
        local env_model = vim.fn.getenv(env_var)
        if env_model ~= vim.NIL and env_model ~= "" then
          return env_model
        end
        return default_model
      end

      local adapter = get_adapter_from_env()

      -- Default models for each adapter
      -- TODO: I'm not sure this should be in source code. The source should be
      -- stable.
      local default_models = {
        anthropic = "claude-3-7-sonnet-latest",
        gemini = "gemini-2.5-pro-preview-03-25",
        ollama = "gemma3:latest"
      }

      require('codecompanion').setup {
        -- Adapter configurations with environment variable support
        adapters = {
          http = {
            anthropic = function()
              return require('codecompanion.adapters').extend('anthropic', {
                schema = {
                  model = {
                    default = get_model_from_env("anthropic", default_models.anthropic),
                  },
                },
              })
            end,
            gemini = function()
              return require('codecompanion.adapters').extend('gemini', {
                schema = {
                  model = {
                    default = get_model_from_env("gemini", default_models.gemini),
                  },
                },
              })
            end,
            ollama = function()
              return require('codecompanion.adapters').extend('ollama', {
                schema = {
                  model = {
                    default = get_model_from_env("ollama", default_models.ollama),
                  },
                },
              })
            end,
          },
        },
        -- Adapter strategies for different interaction modes
        strategies = {
          chat = {
            adapter = adapter,
            strip_comments = false,
            include_context = true,
          },
          inline = {
            adapter = adapter,
            strip_comments = true,
            include_context = false,
          },
        },
        completion = {
          -- TODO: I don't know if these options are relevant anymore
          auto_follow_cursor = true,
          accept_on_insert_mode_only = true,
        },
      }
    end,
  },
}

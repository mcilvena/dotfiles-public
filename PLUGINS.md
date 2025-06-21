# Plugin Documentation

This document provides comprehensive information about all plugins used in this dotfiles configuration, their purposes, custom configurations, and keymaps.

## Neovim Plugins (Lazy.nvim)

### Core Infrastructure

#### **lazy.nvim** (`folke/lazy.nvim`)
- **Purpose**: Modern plugin manager for Neovim
- **Features**: Automatic plugin loading, lazy loading, lockfile support
- **Custom Configuration**: Bootstrap installation from GitHub

#### **mason.nvim** (`williamboman/mason.nvim`)
- **Purpose**: Portable package manager for LSP servers, formatters, and linters
- **Features**: Automatic tool installation and management

### AI & Code Assistant

#### **codecompanion.nvim** (`olimorris/codecompanion.nvim`)
- **Purpose**: AI-powered coding assistant with multiple LLM providers
- **Features**: Chat interface, inline completion, code explanation
- **Custom Configuration**:
  - Environment-based adapter selection (`CODECOMPANION_ADAPTER`)
  - Support for Anthropic Claude, Google Gemini, and Ollama
  - Dynamic model selection via environment variables
- **Keymaps**:
  - `<leader>aa` - AI Actions menu
  - `<leader>ac` - AI Chat toggle
  - `<leader>ae` - AI Explain code (visual mode)
  - `<leader>ai` - AI Improve code
  - `<leader>ad` - AI Documentation
  - `<leader>at` - AI Tests generate
  - `<leader>af` - Add files to AI context
  - `<leader>ar` - Reset AI context

### Language Support

#### **nvim-lspconfig** (`neovim/nvim-lspconfig`)
- **Purpose**: LSP configuration for multiple languages
- **Supported Languages**: Bash, JSON, YAML, TypeScript, TOML, Lua, Rust
- **Custom Configuration**:
  - Rust analyzer with custom settings
  - Lua LSP with vim globals recognition
  - Disabled LSP formatting (deferred to conform.nvim)
- **Keymaps**: Standard LSP navigation (`gd`, `gr`, `gi`, `K`)

#### **nvim-treesitter** (`nvim-treesitter/nvim-treesitter`)
- **Purpose**: Advanced syntax highlighting and code parsing
- **Languages**: Lua, Vim, JavaScript, HTML, JSON, YAML, Rust, Markdown, TOML
- **Features**: Auto-install, highlighting, indentation

### Autocompletion

#### **blink.cmp** (`saghen/blink.cmp`)
- **Purpose**: Fast completion engine (modern nvim-cmp replacement)
- **Features**: Rust fuzzy matching, LSP integration, snippet support
- **Custom Configuration**:
  - Default keymap preset with C-y to accept
  - Sources: LSP, path, snippets, buffer, codecompanion
- **Dependencies**: `friendly-snippets` for snippet support

### File Management & Navigation

#### **oil.nvim** (`stevearc/oil.nvim`)
- **Purpose**: File explorer with edit-like interface
- **Features**: Floating window, preview, hidden files
- **Custom Configuration**: Default file explorer replacement
- **Keymaps**: `-` opens parent directory with preview

#### **telescope.nvim** (`nvim-telescope/telescope.nvim`)
- **Purpose**: Fuzzy finder for files, grep, LSP symbols
- **Extensions**:
  - `telescope-fzf-native.nvim` - Native FZF integration
  - `telescope-recent-files` - Recent files picker
  - `telescope-ui-select.nvim` - UI select replacement
- **Keymaps**:
  - `<C-p>` - Find files
  - `<leader>sf` - Search files
  - `<leader>sg` - Live grep
  - `<leader>sb` - Search buffers
  - `<leader>sh` - Search help
  - `<leader>sr` - Search recent files

### Git Integration

#### **gitsigns.nvim** (`lewis6991/gitsigns.nvim`)
- **Purpose**: Git signs in the gutter, hunk navigation
- **Features**: Blame, hunk preview, staging

#### **git-conflict.nvim** (`akinsho/git-conflict.nvim`)
- **Purpose**: Git merge conflict resolution helpers
- **Features**: Conflict detection, resolution shortcuts

### UI & Interface

#### **mini.nvim** (`echasnovski/mini.nvim`)
- **Components Used**:
  - `mini.icons` - Icon provider
  - `mini.pairs` - Auto-pairs for brackets
  - `mini.statusline` - Custom statusline
  - `mini.sessions` - Session management
- **Custom Configuration**: Statusline with mode, git, filename, LSP status

#### **which-key.nvim** (`folke/which-key.nvim`)
- **Purpose**: Key binding hints and documentation
- **Keymaps**: `<leader>?` for buffer-local keymaps

### Themes & Colorschemes

#### **catppuccin** (`catppuccin/nvim`)
- **Purpose**: Main colorscheme (Catppuccin Mocha)
- **Features**: Extensive plugin integrations
- **Custom Configuration**: Integrations for cmp, gitsigns, treesitter, mini

#### **tokyonight.nvim** (`folke/tokyonight.nvim`)
- **Purpose**: Alternative colorscheme (lazy-loaded)

#### **huez.nvim** (`vague2k/huez.nvim`)
- **Purpose**: Colorscheme manager with live preview

### Code Formatting

#### **conform.nvim** (`stevearc/conform.nvim`)
- **Purpose**: Code formatter with multiple formatter support
- **Formatters by Language**:
  - Lua: stylua
  - Rust: rustfmt
  - JavaScript/TypeScript: prettierd/prettier
  - HTML/CSS/JSON/YAML/Markdown: prettierd/prettier
  - Bash: shfmt
  - TOML: taplo
- **Features**: Format on save, async formatting
- **Keymaps**: `<leader>cf` for manual formatting

### Language-Specific Plugins

#### **crates.nvim** (`saecki/crates.nvim`) - Rust
- **Purpose**: Cargo.toml dependency management
- **Features**: LSP integration, version popups, dependency info
- **Keymaps**: Extensive Rust crate management under `<leader>R` prefix

#### **markdown-preview.nvim** (`iamcco/markdown-preview.nvim`)
- **Purpose**: Live markdown preview in browser
- **Features**: Real-time preview, math support

### Terminal Integration

#### **toggleterm.nvim** (`akinsho/toggleterm.nvim`)
- **Purpose**: Floating terminal integration
- **Features**: Lazygit integration, persistent terminals
- **Keymaps**:
  - `<C-\>` - Toggle terminal
  - `<leader>g` - Lazygit in floating terminal
  - `<leader>tt` - Float terminal toggle

### Code Folding

#### **nvim-ufo** (`kevinhwang91/nvim-ufo`)
- **Purpose**: Enhanced folding with LSP support
- **Features**: LSP + treesitter folding, fold preview
- **Keymaps**: Custom fold navigation (`Tab`, `zj`, `zk`)

## Zsh Plugins (Zinit)

### Core Framework

#### **zinit** (`zdharma-continuum/zinit`)
- **Purpose**: Fast and feature-rich Zsh plugin manager
- **Features**: Turbo mode, ice modifiers, snippet support

#### **powerlevel10k** (`romkatv/powerlevel10k`)
- **Purpose**: Fast and customizable Zsh prompt
- **Features**: Git status, instant prompt, transient prompt
- **Configuration**: Pure-style prompt with custom colors

### Zsh Enhancements

#### **zsh-syntax-highlighting** (`zsh-users/zsh-syntax-highlighting`)
- **Purpose**: Real-time syntax highlighting for commands
- **Features**: Command validation, error highlighting

#### **zsh-completions** (`zsh-users/zsh-completions`)
- **Purpose**: Additional completion definitions
- **Features**: Extended completion for many tools

#### **zsh-autosuggestions** (`zsh-users/zsh-autosuggestions`)
- **Purpose**: Command suggestions based on history
- **Features**: Ghost text completions

#### **fzf-tab** (`Aloxaf/fzf-tab`)
- **Purpose**: Replace tab completion with fzf interface
- **Features**: Directory previews, fuzzy matching
- **Custom Configuration**: Directory previews with ls

### Oh My Zsh Plugins

#### **OMZP::aws**
- **Purpose**: AWS CLI completions and utilities
- **Features**: AWS profile management, completions

#### **OMZP::command-not-found**
- **Purpose**: Suggests packages for unknown commands
- **Features**: Package suggestions on command not found

#### **OMZP::git**
- **Purpose**: Git aliases and functions
- **Features**: Extensive git shortcuts

#### **OMZP::sudo**
- **Purpose**: ESC twice to add sudo to command
- **Features**: Quick sudo prefix addition

### Modern Tool Integrations

#### **zoxide**
- **Purpose**: Smart directory jumping (aliased as `cd`)
- **Features**: Frecency-based directory navigation

#### **fzf**
- **Purpose**: Fuzzy finder with fd integration
- **Features**: Command history, file search

#### **direnv**
- **Purpose**: Directory-specific environment variables
- **Features**: Automatic environment loading

## Tmux Plugins (TPM)

### Core Framework

#### **tpm** (`tmux-plugins/tpm`)
- **Purpose**: Tmux Plugin Manager
- **Features**: Plugin installation, updates

#### **tmux-sensible** (`tmux-plugins/tmux-sensible`)
- **Purpose**: Sensible tmux defaults
- **Features**: Better key bindings, mouse support

### UI & Navigation

#### **tmux-which-key** (`alexwforsythe/tmux-which-key`)
- **Purpose**: Key binding hints for tmux
- **Features**: Interactive key binding help

#### **catppuccin/tmux** (v2.0.0)
- **Purpose**: Catppuccin theme for tmux
- **Features**: Mocha flavor, custom status bar
- **Custom Configuration**: Window text with current path

## Modern CLI Tool Replacements

### File Operations
- **eza** (replaces `ls`) - Modern ls with git integration, icons
- **bat** (replaces `cat`) - Syntax highlighting, paging
- **fd** (replaces `find`) - Faster file finding
- **rg** (replaces `grep`) - Ripgrep for faster searching

### System Monitoring
- **btop** (replaces `top`) - Modern system monitor
- **dust** (replaces `du`) - Better disk usage display

### Navigation
- **zoxide** (replaces `cd`) - Smart directory jumping
- **fzf** - Fuzzy finder for everything

## Personal Plugin Dependencies

### Plugins That May Not Work for Others

#### **codecompanion.nvim** - AI Assistant
- **Dependency**: Requires API keys for LLM providers
- **Environment Variables**: `CODECOMPANION_ADAPTER`, `ANTHROPIC_API_KEY`
- **Alternative**: Disable or replace with local AI solutions

#### **AWS-related configurations**
- **Dependency**: AWS CLI and credentials
- **Files**: `.zshrc` AWS authentication section
- **Alternative**: Comment out AWS-specific sections

### Optional Plugins

#### **crates.nvim** - Rust Development
- **Purpose**: Only useful for Rust developers
- **Alternative**: Disable if not using Rust

#### **markdown-preview.nvim**
- **Dependency**: Node.js for preview server
- **Alternative**: Use any markdown previewer

## Customization Guide

### Adding New Plugins

1. **Neovim**: Add to `src/.config/nvim/lua/plugins/`
2. **Zsh**: Add to `src/.zshrc` in zinit section
3. **Tmux**: Add to `src/.tmux.conf` with TPM

### Disabling Plugins

1. **Neovim**: Set `enabled = false` in plugin spec
2. **Zsh**: Comment out zinit load line
3. **Tmux**: Comment out plugin line

### Custom Keymaps

- **Neovim**: Edit `src/.config/nvim/lua/keymaps.lua`
- **Tmux**: Edit `src/.tmux.conf`
- **Zsh**: Add to `src/.zshrc` or `src/.aliases`

## Installation Notes

### Automatic Installation
Most plugins are automatically installed on first run:
- Neovim: lazy.nvim handles plugin installation
- Zsh: zinit handles plugin installation
- Tmux: TPM handles plugin installation (`<prefix>I`)

### Manual Steps Required
1. **Tmux**: Press `<prefix>I` to install plugins
2. **Neovim**: Run `:Lazy` to manage plugins
3. **Zsh**: Restart shell or run `exec zsh`

### Troubleshooting
- **Neovim**: Check `:checkhealth` for issues
- **Zsh**: Check `~/.zinit` directory exists
- **Tmux**: Ensure TPM is cloned to `~/.tmux/plugins/tpm`
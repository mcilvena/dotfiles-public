# Modern Neovim Configuration

A comprehensive, AI-powered Neovim configuration built for modern development workflows. This setup emphasizes productivity, intelligent code assistance, and a clean, minimalist design using the Catppuccin Mocha theme.

## 🤖 AI-Powered Features

This configuration's standout feature is its integrated AI assistance through CodeCompanion, providing intelligent code generation, documentation, and chat-based development support.

### CodeCompanion Integration
- **Multiple AI Providers**: Supports Anthropic Claude, Google Gemini, and Ollama
- **Environment-Based Configuration**: Switch providers and models via environment variables
- **Intelligent Context**: Automatically includes relevant code context in AI conversations
- **Inline Code Generation**: AI-powered code completion and suggestions
- **Documentation Generation**: Automatic documentation and comment generation

## 🚀 Quick Start

### prerequisites
- **Neovim 0.10+**: Latest version recommended
- **Git**: For plugin management and version control
- **Node.js**: Required for some language servers and formatters
- **Rust**: For enhanced performance with tree-sitter and some plugins
- **AI API Key**: For CodeCompanion features (optional but recommended)

### Installation
This configuration is designed to work as part of the broader dotfiles setup:

```bash
# Clone the dotfiles repository
git clone https://github.com/mcilvena/dotfiles-public.git ~/dotfiles
cd ~/dotfiles

# Install system dependencies (macOS/Linux)
./install/macos.sh    # or ./install/ubuntu.sh or ./install/arch-linux.sh

# Deploy dotfiles (includes Neovim config)
make stow

# Set up environment variables (optional)
cp src/.env-example .env
# Edit .env with your API keys and preferences
```

### First Launch
On first launch, Neovim will:
1. Automatically install Lazy.nvim plugin manager
2. Download and install all configured plugins
3. Set up language servers via Mason
4. Configure treesitter parsers for syntax highlighting

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── options.lua         # Core Neovim options
│   ├── keymaps.lua         # Global keybindings
│   ├── config/
│   │   └── lazy.lua        # Plugin manager setup
│   └── plugins/            # Plugin configurations
│       ├── ai.lua          # AI assistant (CodeCompanion)
│       ├── lsp.lua         # Language Server Protocol
│       ├── telescope.lua   # Fuzzy finder
│       ├── treesitter.lua  # Syntax highlighting
│       ├── cmp.lua         # Autocompletion
│       ├── colorschemes.lua # Themes and colors
│       ├── git.lua         # Git integration
│       ├── oil.lua         # File explorer
│       ├── terminal.lua    # Terminal integration
│       ├── folding.lua     # Code folding
│       ├── conform.lua     # Code formatting
│       ├── mini.lua        # Mini plugin collection
│       ├── which-key.lua   # Keymap discovery
│       ├── rust.lua        # Rust development
│       └── markdown.lua    # Markdown support
├── after/
│   └── ftplugin/           # Filetype-specific settings
└── snippets/               # Custom code snippets
```

## 🎨 Theme and Appearance

- **Primary Theme**: Catppuccin Mocha (warm, pastel dark theme)
- **Backup Theme**: Tokyo Night
- **Theme Manager**: Huez for easy theme switching
- **Font**: JetBrains Mono Nerd Font (for icon support)
- **UI Elements**: Consistent rounded borders and modern styling

## 🔧 Core Features

### Language Support
Comprehensive language support with LSP integration:

| Language | LSP Server | Formatter | Features |
|----------|------------|-----------|----------|
| **Lua** | lua_ls | stylua | Full Neovim API support |
| **Rust** | rust-analyzer | rustfmt | Cargo.toml management, crates.nvim |
| **JavaScript/TypeScript** | ts_ls | prettier/prettierd | Modern JS/TS development |
| **JSON/YAML** | jsonls/yamlls | prettier | Configuration file editing |
| **Bash** | bashls | shfmt | Shell script development |
| **TOML** | taplo | taplo | Configuration files |

### File Management
- **Oil.nvim**: Modern file explorer with buffer-like editing
- **Telescope**: Powerful fuzzy finder for files, buffers, and symbols
- **Recent Files**: Quick access to recently opened files

### Git Integration
- **Gitsigns**: Visual git status in the gutter
- **Git Conflict**: Inline conflict resolution
- **Lazygit**: Terminal-based Git UI (via floating terminal)

### Terminal Integration
- **ToggleTerm**: Floating terminal windows
- **Persistent Sessions**: Terminal state preserved across sessions
- **Lazygit Integration**: Quick access to Git operations

### Code Intelligence
- **LSP**: Full Language Server Protocol support
- **Treesitter**: Advanced syntax highlighting and code parsing
- **Autocompletion**: Fast completion with blink.cmp
- **Code Folding**: Intelligent folding with nvim-ufo
- **Diagnostics**: Real-time error and warning display

## ⌨️ Key Mappings

### Leader Key
- **Leader**: `<Space>` (Space bar)

### AI Assistant (`<leader>a`)
| Mapping | Mode | Action |
|---------|------|--------|
| `<leader>aa` | Normal/Visual | Open AI actions menu |
| `<leader>ac` | Normal/Visual | Toggle AI chat |
| `<leader>ae` | Visual | Explain selected code |
| `<leader>ai` | Normal/Visual | Improve code |
| `<leader>ad` | Normal/Visual | Generate documentation |
| `<leader>at` | Normal/Visual | Generate tests |
| `<leader>af` | Normal | Add files to AI context |
| `<leader>ar` | Normal | Reset AI context |

### File Operations (`<leader>s`)
| Mapping | Action |
|---------|--------|
| `<C-p>` | Find files |
| `<leader><leader>` | Recent files |
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep search |
| `<leader>sh` | Help tags |
| `<leader>ss` | Document symbols |
| `<leader>sS` | Workspace symbols |
| `<leader>sr` | LSP references |
| `<leader>sd` | Diagnostics |
| `<leader>sn` | Search Neovim config |
| `<leader>sk` | Search keymaps |

### Buffer Management (`<leader>b`)
| Mapping | Action |
|---------|--------|
| `<leader>bd` / `<leader>x` | Delete buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>ba` | Close all buffers |

### Window Management (`<leader>w`)
| Mapping | Action |
|---------|--------|
| `<leader>wh` | Horizontal split |
| `<leader>wv` | Vertical split |
| `<leader>wc` | Close window |
| `<leader>wo` | Close other windows |
| `<C-h/j/k/l>` | Navigate windows |

### Code Operations (`<leader>c`)
| Mapping | Action |
|---------|--------|
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>ce` | Show diagnostics |
| `<leader>cf` | Format code |
| `<leader>cq` | Quickfix list |

### LSP Navigation
| Mapping | Action |
|---------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `[d` / `]d` | Previous/Next diagnostic |

### Folding
| Mapping | Action |
|---------|--------|
| `<Tab>` | Toggle fold |
| `zj` / `zk` | Next/Previous fold |
| `zh` / `zl` | Close/Open fold |
| `z1-z5` | Set fold levels |
| `z0` | Open all folds |

### Rust Development (`<leader>R`)
Comprehensive Rust-specific keybindings for Cargo.toml management:
| Mapping | Action |
|---------|--------|
| `<leader>Rt` | Toggle crates display |
| `<leader>Rv` | Show versions |
| `<leader>Rf` | Show features |
| `<leader>Ru` | Update crate |
| `<leader>RH` | Open homepage |
| `<leader>RD` | Open documentation |

### Terminal and Git
| Mapping | Action |
|---------|--------|
| `<leader>tt` | Toggle floating terminal |
| `<leader>g` | Open Lazygit |
| `<C-\>` | Toggle terminal |

### File Explorer
| Mapping | Action |
|---------|--------|
| `-` | Open file explorer with preview |
| `q` | Close file explorer |

### Line Movement
| Mapping | Mode | Action |
|---------|------|--------|
| `<Alt-Up>` / `<Alt-Down>` | Normal | Move line up/down |
| `<Alt-Up>` / `<Alt-Down>` | Visual | Move selection up/down |

### General
| Mapping | Action |
|---------|--------|
| `<C-s>` | Save file |
| `<C-c>` | Copy current word |
| `<Esc>` | Clear search highlight |
| `<leader>rr` | Reload configuration |

## 🔌 Plugin Ecosystem

### Core Plugins

#### Plugin Manager
- **Lazy.nvim**: Modern, fast plugin manager with lazy loading

#### AI Assistant
- **CodeCompanion**: Multi-provider AI assistant with chat interface
- **Environment Configuration**: Supports Anthropic, Gemini, and Ollama

#### Language Support
- **nvim-lspconfig**: LSP client configuration
- **Mason**: Language server installer and manager
- **Treesitter**: Syntax highlighting and code parsing
- **blink.cmp**: Fast autocompletion engine

#### File Management
- **Telescope**: Fuzzy finder with extensive extensions
- **Oil.nvim**: File explorer with buffer-like editing
- **telescope-recent-files**: Quick access to recent files

#### Git Integration
- **Gitsigns**: Git status in the gutter
- **git-conflict.nvim**: Inline conflict resolution

#### Code Quality
- **Conform.nvim**: Multi-formatter code formatting
- **nvim-ufo**: Advanced code folding

#### UI/UX
- **Catppuccin**: Primary colorscheme
- **Which-key**: Keymap discovery
- **Mini collection**: Statusline, icons, pairs, sessions

#### Terminal
- **ToggleTerm**: Floating terminal integration

#### Language-Specific
- **crates.nvim**: Rust Cargo.toml management
- **markdown-preview.nvim**: Live markdown preview

### Plugin Configuration Philosophy

1. **Minimal Configuration**: Plugins are configured with sensible defaults
2. **Performance First**: Lazy loading and optimized setups
3. **Consistency**: Unified theming and keybinding patterns
4. **Modularity**: Each plugin in its own configuration file
5. **Environment Awareness**: Configurable via environment variables

## 🔧 Customization

### Environment Variables
Configure AI providers and models via environment variables:

```bash
# ~/.env file
CODECOMPANION_ADAPTER=anthropic                    # or gemini, ollama
CODECOMPANION_ANTHROPIC_MODEL=claude-3-5-sonnet-latest
CODECOMPANION_GEMINI_MODEL=gemini-2.0-flash-exp
CODECOMPANION_OLLAMA_MODEL=llama3.2:latest
```

### Adding New Plugins
1. Create a new file in `lua/plugins/`
2. Return a table with plugin specifications
3. Lazy.nvim will automatically load the plugin

```lua
-- lua/plugins/example.lua
return {
  'author/plugin-name',
  config = function()
    -- Plugin configuration
  end,
}
```

### Modifying Keymaps
Edit `lua/keymaps.lua` or plugin-specific files to customize keybindings:

```lua
vim.keymap.set('n', '<leader>custom', function()
  -- Your custom function
end, { desc = 'Custom action' })
```

### Theme Customization
Switch themes easily with Huez:
- `:Huez` - Open theme picker
- `:colorscheme <theme-name>` - Apply theme directly

## 🛠️ Development Workflow

### Typical Development Session
1. **File Navigation**: Use `<C-p>` or `<leader>sf` to find files
2. **Code Analysis**: Jump to definitions with `gd`, find references with `gr`
3. **AI Assistance**: Use `<leader>aa` for AI actions, `<leader>ac` for chat
4. **Code Formatting**: Automatic on save, manual with `<leader>cf`
5. **Git Operations**: Use `<leader>g` for Lazygit interface
6. **Terminal**: Toggle with `<leader>tt` for command execution

### Rust Development
- Edit `Cargo.toml` with intelligent crate completion
- Use `<leader>R*` mappings for crate management
- Rust-analyzer provides excellent LSP support
- Automatic formatting with rustfmt on save

### Markdown Workflow
- Live preview with `:MarkdownPreview`
- Smart checkbox toggling with `<Enter>`
- Automatic timestamp insertion for completed tasks

## 🐛 Troubleshooting

### Common Issues

**Plugin Installation Fails**
```bash
# Remove lazy-lock.json and restart
rm ~/.config/nvim/lazy-lock.json
nvim
```

**LSP Not Working**
```bash
# Check Mason installations
:Mason
:LspInfo
```

**AI Features Not Working**
- Verify API key in `.env` file
- Check network connectivity
- Ensure correct adapter is configured

**Formatting Not Working**
- Check `:ConformInfo` for formatter status
- Install formatters via Mason or system package manager

### Performance Issues
- Check `:Lazy profile` for plugin loading times
- Ensure treesitter parsers are compiled: `:TSUpdate`
- Clear unused plugins: `:Lazy clean`

### Useful Commands
- `:checkhealth` - Comprehensive health check
- `:Lazy` - Plugin manager interface
- `:Mason` - Language server manager
- `:Telescope` - Fuzzy finder interface
- `:LspInfo` - LSP status information
- `:ConformInfo` - Formatter status

## 📚 Learning Resources

### Neovim Basics
- [Neovim Documentation](https://neovim.io/doc/user/)
- [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)

### Plugin Documentation
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [CodeCompanion](https://github.com/olimorris/codecompanion.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)

## 🤝 Contributing

This configuration is part of a personal dotfiles setup, but improvements are welcome:

1. **Issues**: Report bugs or suggest features
2. **Pull Requests**: Submit improvements with clear descriptions
3. **Documentation**: Help improve this README or add inline documentation

## 📄 License

This configuration is part of the broader dotfiles project licensed under the MIT License. See the main repository for details.

---

*This Neovim configuration is designed to be a comprehensive, AI-enhanced development environment that grows with your needs. The modular structure makes it easy to customize and extend while maintaining performance and reliability.*
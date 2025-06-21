# Personal Dotfiles

A comprehensive, cross-platform dotfiles configuration for macOS, Windows, and Linux environments. This configuration emphasizes modern tooling, consistent theming, and AI-assisted developer productivity.

## 🤖 AI-Powered Development Features

This dotfiles setup includes integrated AI assistance for enhanced development workflows:

- **🧠 Neovim AI Assistant**: Built-in CodeCompanion plugin supporting multiple AI providers:
  - **Anthropic Claude** (default): Industry-leading code generation and analysis
  - **Google Gemini**: Alternative AI model with strong reasoning capabilities  
  - **Ollama**: Local AI models for offline development
  - Environment variable configuration for easy provider/model switching
  - Chat interface and inline code generation directly in your editor

- **📝 AI-Generated Git Commits**: LazyGit integration with Claude Code:
  - Press `C` in LazyGit to auto-generate contextual commit messages
  - Analyzes staged changes to create meaningful commit descriptions
  - Generates both summary line and detailed commit body
  - Streamlines git workflow with intelligent commit message suggestions

- **⚙️ Configurable AI Environment**: 
  - `CODECOMPANION_ADAPTER`: Choose your preferred AI provider
  - `CODECOMPANION_*_MODEL`: Specify models for each provider
  - Easy switching between different AI services based on your needs

## Features

- **Cross-Platform Support**: Works on macOS (work), Windows (personal), and Linux (personal)
- **Modern CLI Tools**: Replaces traditional tools with faster, feature-rich alternatives
- **Consistent Theming**: Catppuccin Mocha theme across all applications
- **Modern Editor**: Neovim configuration with Lazy.nvim setup
- **Git Workflow**: Enhanced git experience with delta diffs and lazygit UI
- **Shell Enhancement**: Zsh with modern completions and smart directory navigation

## Quick Start

### Prerequisites

#### System Requirements
- **Operating System**: macOS 10.15+, Ubuntu 20.04+, Arch Linux, or Windows 10+ with WSL2
- **Shell**: Zsh (will be configured automatically)
- **Terminal**: Any modern terminal emulator (recommendations included)

#### Required Tools
Before installation, ensure you have:
- **Git** (for cloning and version control)
- **Stow** (for dotfiles management) - installed via setup scripts if missing
- **Curl** or **wget** (for downloading tools)

#### Platform-Specific Dependencies
**macOS:**
- Xcode Command Line Tools: `xcode-select --install`
- Homebrew (installed automatically by setup script)

**Linux:**
- Build essentials (`gcc`, `make`, `build-essential` on Ubuntu)
- Package manager (`apt`, `pacman`, `yum`, etc.)

**Windows:**
- WSL2 with Ubuntu or Debian distribution
- Windows Terminal (recommended)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install system-specific tools:**
   ```bash
   # macOS
   ./install/brew/install.sh          # CLI tools
   ./install/brew/install-fonts.sh    # Fonts
   ./install/brew/install-casks.sh    # GUI applications

   # Ubuntu/Debian Linux
   ./install/ubuntu.sh

   # Arch Linux
   ./install/arch-linux.sh
   ```

3. **Deploy dotfiles:**
   ```bash
   make stow
   ```

4. **Verify installation:**
   ```bash
   make check
   ```

## Directory Structure

```
dotfiles/
├── src/                    # Dotfiles source (managed by stow)
│   ├── .config/           # XDG-compliant application configs
│   │   ├── alacritty/     # Terminal emulator config
│   │   ├── ghostty/       # Alternative terminal config
│   │   ├── nvim/          # Modern Neovim with Lazy.nvim
│   │   ├── lazygit/       # Git terminal UI config
│   │   ├── bat/           # Syntax highlighter config
│   │   └── delta/         # Git diff enhancement config
│   ├── .zshrc             # Zsh shell configuration
│   ├── .gitconfig         # Git configuration with includes
│   ├── .aliases           # Shell aliases and shortcuts
│   └── .wezterm.lua       # WezTerm terminal config
├── install/               # Installation scripts
│   ├── ubuntu.sh         # Ubuntu/Debian specific tools
│   ├── arch-linux.sh     # Arch Linux specific tools
│   └── macos.sh          # macOS installation script
└── docs/                 # Documentation
```

## Key Tools and Replacements

| Traditional | Modern Alternative | Purpose |
|-------------|-------------------|---------|
| `ls` | `eza` | Directory listing with icons |
| `cat` | `bat` | Syntax highlighting and paging |
| `find` | `fd` | Fast file finder |
| `grep` | `ripgrep` | Fast text search |
| `cd` | `zoxide` | Smart directory navigation |
| `git diff` | `delta` | Enhanced git diffs |
| `top/htop` | Built-in | Process monitoring |

## Configuration Highlights

### Shell (Zsh)
- **Plugin Manager**: Zinit for fast plugin loading
- **Prompt**: Powerlevel10k with custom configuration
- **Completions**: Modern tab completion system
- **Aliases**: Shortcuts for modern CLI tools

### Terminal Emulators
Configurations provided for:
- **Alacritty**: GPU-accelerated terminal
- **Ghostty**: Fast, feature-rich terminal
- **WezTerm**: Terminal with advanced features
- **iTerm2**: macOS-specific terminal (via preferences)

All terminals use:
- **Font**: JetBrainsMono Nerd Font (consistent across platforms)
- **Theme**: Catppuccin Mocha
- **Key bindings**: Standardized shortcuts

### Text Editors

#### Neovim
Configuration available:
- **Lazy.nvim** (`~/.config/nvim` → `nvim/`) - Modern plugin management

Features:
- LSP integration for multiple languages
- Fuzzy finding with telescope
- Git integration
- Modern UI with consistent theming

### Git Configuration
- **Modular Config**: Separate files for personal/work contexts
- **Enhanced Diffs**: Delta for syntax-highlighted diffs
- **Extensive Aliases**: GitAlias.com collection (1,749 aliases)
- **Conditional Includes**: Context-aware configuration

## Development Workflow

### Daily Commands
```bash
# Management
make stow          # Deploy dotfiles
make unstow        # Remove dotfiles
make restow        # Redeploy dotfiles
make backup        # Create timestamped backup
make restore       # Restore from latest backup

# Development
make lint          # Run shellcheck on scripts
make test          # Run tests (when implemented)
```

### Git Integration
- Use `lazygit` for terminal-based git UI
- Delta provides enhanced diff viewing
- Extensive alias collection for common operations
- Context-aware configuration for work vs personal

### Shell Productivity
- `z <partial-path>` - Smart directory jumping
- `ll`, `la` - Enhanced directory listings
- `bathelp <command>` - Colorized help pages
- `fzf` integration for command history and file search

## Platform-Specific Notes

### macOS
- GUI applications installed to `~/Applications`
- Homebrew manages all CLI tools and fonts
- iTerm2 preferences included for import

### Linux
- System package managers used for base tools
- Manual installation of newer tools from GitHub releases
- Font installation to `~/.local/share/fonts`

### Windows
- Works via WSL2 with Ubuntu configuration
- Windows Terminal configuration can be added

#### WezTerm Configuration Sync for WSL

When using WezTerm in Windows with WSL, you can sync your dotfiles WezTerm configuration to the Windows installation:

**Environment Variables (Optional):**
- `DOTFILES_ROOT`: Path to your dotfiles directory (default: `$HOME/dotfiles`)  
- `WINDOWS_USER`: Windows username (default: current WSL username)

**Setting Environment Variables:**
```bash
# In your ~/.zshrc or ~/.bashrc
export DOTFILES_ROOT="$HOME/dotfiles"
export WINDOWS_USER="YourWindowsUsername"
```

**Manual Sync:**
```bash
# Run the sync script manually
./scripts/sync-wezterm.sh
```

**Automatic Setup:**
The sync script automatically detects WSL environment and syncs `src/.wezterm.lua` to `/mnt/c/Users/$WINDOWS_USER/.wezterm.lua`.

## Customization

### Adding New Tools
1. Add installation commands to appropriate install script
2. Create configuration file in `src/`
3. Update README with tool information

### Theme Customization
All applications use Catppuccin Mocha. To change:
1. Update theme references in configs
2. Rebuild bat cache: `bat cache --build`

### Local Overrides
- Git: Use `.gitconfig-local` for machine-specific settings
- Environment: Use `.env` for local environment variables
- Shell: Add local customizations to `.zshrc.local`

## Troubleshooting

### Common Issues

**Stow conflicts:**
```bash
make unstow    # Remove existing links
make clean     # Clean up broken links
make stow      # Redeploy
```

**Font not displaying:**
- Ensure Nerd Fonts are installed
- Rebuild font cache: `fc-cache -f` (Linux)
- Restart terminal application

**Shell completions missing:**
- Reload shell: `exec zsh`
- Check plugin installation in `~/.zinit`

## Contributing

This is a personal dotfiles repository, but suggestions and improvements are welcome:

1. Fork the repository
2. Create a feature branch
3. Test changes across platforms
4. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Catppuccin](https://catppuccin.com/) for the beautiful color scheme
- [GitAlias.com](https://github.com/GitAlias/gitalias) for comprehensive git aliases
- [Zinit](https://github.com/zdharma-continuum/zinit) for fast zsh plugin management
- The open source community for modern CLI tool alternatives


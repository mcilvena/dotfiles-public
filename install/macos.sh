#!/bin/bash

# =============================================================================
# macOS Dotfiles Dependencies Installation Script
# =============================================================================
# This script installs all the required dependencies for the dotfiles to work
# properly on macOS. It handles Homebrew installations and configurations.

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi
}

# Check if Homebrew is installed
check_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        print_status "Homebrew is available"
        return 0
    else
        print_warning "Homebrew is not installed"
        return 1
    fi
}

# Install Homebrew if not present
install_homebrew() {
    print_status "Installing Homebrew..."
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_success "Homebrew installed (Apple Silicon)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
        print_success "Homebrew installed (Intel)"
    else
        print_error "Homebrew installation failed"
        exit 1
    fi
}

# Update Homebrew
update_homebrew() {
    print_status "Updating Homebrew..."
    brew update
    brew upgrade
    print_success "Homebrew updated"
}

# Install packages from Homebrew
install_homebrew_packages() {
    print_status "Installing packages from Homebrew..."
    
    # Core system tools
    local core_packages=(
        "zsh"                # Z shell (though macOS has it by default)
        "make"               # Build tool
        "stow"               # Symlink farm manager
        "git"                # Version control
        "curl"               # HTTP client
        "wget"               # File downloader
        "cmake"              # Build system
        "gcc"                # C compiler
    )
    
    # Modern CLI tools (replacements for standard tools)
    local cli_tools=(
        "bat"                # Enhanced cat with syntax highlighting
        "eza"                # Modern ls replacement
        "zoxide"             # Smart cd command
        "ripgrep"            # Fast grep replacement
        "fd"                 # Fast find replacement
        "dust"               # Better du replacement
        "duf"                # Better df replacement
        "btop"               # Better top replacement
        "fzf"                # Fuzzy finder
        "dog"                # Modern dig alternative
    )
    
    # Development tools
    local dev_tools=(
        "neovim"             # Text editor
        "tmux"               # Terminal multiplexer
        "direnv"             # Environment switcher
        "lazygit"            # Git TUI
        "git-delta"          # Better git diffs
        "lua"                # Lua interpreter
        "python3"            # Python interpreter
        "sqlite"             # SQLite database
        "jq"                 # JSON processor
    )
    
    # Programming languages and runtimes
    local languages=(
        "node"               # Node.js (includes npm)
        "yarn"               # Yarn package manager
        "pnpm"               # PNPM package manager
        "typescript"         # TypeScript
        "prettier"           # Code formatter
        "go"                 # Go language
        "rust"               # Rust language
        "rustup"             # Rust toolchain installer
        "deno"               # Deno runtime
    )
    
    # Code quality tools
    local quality_tools=(
        "shellcheck"         # Shell script linter
        "shfmt"              # Shell script formatter
    )
    
    # Cloud tools (optional)
    local cloud_tools=(
        "awscli"             # AWS CLI
        "aws-cdk"            # AWS CDK
    )
    
    # Combine all packages
    local all_packages=(
        "${core_packages[@]}"
        "${cli_tools[@]}"
        "${dev_tools[@]}"
        "${languages[@]}"
        "${quality_tools[@]}"
        "${cloud_tools[@]}"
    )
    
    # Install packages
    for package in "${all_packages[@]}"; do
        if brew list "$package" >/dev/null 2>&1; then
            print_status "$package is already installed"
        else
            print_status "Installing $package..."
            if ! brew install "$package" 2>/dev/null; then
                print_warning "Failed to install $package, it may not be available"
            fi
        fi
    done
    
    print_success "Homebrew packages installation completed"
}

# Install GUI applications via Homebrew Casks
install_gui_applications() {
    print_status "Installing GUI applications..."
    
    # Terminal emulators
    local terminals=(
        "alacritty"          # GPU-accelerated terminal
        "ghostty"            # Modern terminal emulator
        "wezterm"            # GPU-accelerated terminal multiplexer
    )
    
    # Productivity apps
    local productivity=(
        "obsidian"           # Note-taking app
        "raycast"            # Launcher and productivity tool
        "soulver"            # Calculator with natural language
    )
    
    # Cloud and storage
    local cloud_storage=(
        "google-drive"       # Google Drive
    )
    
    # Development and AI
    local dev_ai=(
        "ollama"             # Local LLM runner
    )
    
    # Communication
    local communication=(
        "readdle-spark"      # Email client
    )
    
    # Combine all GUI apps
    local all_apps=(
        "${terminals[@]}"
        "${productivity[@]}"
        "${cloud_storage[@]}"
        "${dev_ai[@]}"
        "${communication[@]}"
    )
    
    # Install applications to user's Applications folder
    for app in "${all_apps[@]}"; do
        if brew list --cask "$app" >/dev/null 2>&1; then
            print_status "$app is already installed"
        else
            print_status "Installing $app..."
            if ! brew install --cask --appdir="$HOME/Applications" "$app" 2>/dev/null; then
                print_warning "Failed to install $app, it may not be available"
            fi
        fi
    done
    
    print_success "GUI applications installation completed"
}

# Install fonts
install_fonts() {
    print_status "Installing fonts..."
    
    # Add fonts tap if not already added
    if ! brew tap | grep -q "homebrew/cask-fonts"; then
        print_status "Adding homebrew/cask-fonts tap..."
        brew tap homebrew/cask-fonts
    fi
    
    # Font packages
    local fonts=(
        "font-jetbrains-mono-nerd-font"  # Primary programming font
        "font-fira-code-nerd-font"       # Alternative programming font
        "font-hack-nerd-font"            # Alternative programming font
        "font-damion"                    # Design/display font
    )
    
    # Install fonts
    for font in "${fonts[@]}"; do
        if brew list --cask "$font" >/dev/null 2>&1; then
            print_status "$font is already installed"
        else
            print_status "Installing $font..."
            if ! brew install --cask "$font" 2>/dev/null; then
                print_warning "Failed to install $font, it may not be available"
            fi
        fi
    done
    
    print_success "Fonts installation completed"
}

# Install additional Node.js tools
install_node_tools() {
    print_status "Installing Node.js global packages..."
    
    # Check if npm is available
    if command -v npm >/dev/null 2>&1; then
        # Install corepack
        if ! command -v corepack >/dev/null 2>&1; then
            print_status "Installing corepack..."
            npm install -g corepack
        else
            print_status "corepack is already installed"
        fi
    else
        print_warning "npm not available, skipping Node.js tools"
    fi
    
    print_success "Node.js tools processed"
}

# Install and configure Catppuccin theme for bat
install_catppuccin_bat() {
    print_status "Installing Catppuccin themes for bat..."
    
    # Check if bat is installed
    if command -v bat >/dev/null 2>&1; then
        # Create bat themes directory
        local bat_themes_dir="$(bat --config-dir)/themes"
        mkdir -p "$bat_themes_dir"
        
        # Define all Catppuccin themes
        local themes=(
            "Catppuccin%20Latte.tmTheme:Catppuccin-Latte.tmTheme"
            "Catppuccin%20Frappe.tmTheme:Catppuccin-Frappe.tmTheme"
            "Catppuccin%20Macchiato.tmTheme:Catppuccin-Macchiato.tmTheme"
            "Catppuccin%20Mocha.tmTheme:Catppuccin-Mocha.tmTheme"
        )
        
        local themes_installed=false
        
        # Download each theme if not already present
        for theme_info in "${themes[@]}"; do
            local url_name="${theme_info%%:*}"
            local file_name="${theme_info##*:}"
            local theme_file="$bat_themes_dir/$file_name"
            
            if [[ ! -f "$theme_file" ]]; then
                print_status "Downloading $file_name theme for bat..."
                curl -L -o "$theme_file" "https://github.com/catppuccin/bat/raw/main/themes/$url_name"
                themes_installed=true
            fi
        done
        
        # Rebuild bat cache if any themes were installed
        if [[ "$themes_installed" == true ]]; then
            print_status "Rebuilding bat theme cache..."
            bat cache --build
            print_success "Catppuccin themes for bat installed"
        else
            print_status "Catppuccin themes for bat already installed"
        fi
    else
        print_warning "bat not installed, skipping Catppuccin themes"
    fi
}

# Configure Rust toolchain
configure_rust() {
    print_status "Configuring Rust toolchain..."
    
    if command -v rustup >/dev/null 2>&1; then
        # Update existing installation
        rustup update
        rustup default stable
        rustup component add clippy rustfmt
        print_success "Rust toolchain configured"
    else
        print_warning "rustup not found, skipping Rust configuration"
    fi
}

# Install Zinit (Zsh plugin manager)
install_zinit() {
    print_status "Installing Zinit (Zsh plugin manager)..."
    
    local zinit_home="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    
    if [[ ! -d "$zinit_home" ]]; then
        mkdir -p "$(dirname "$zinit_home")"
        git clone https://github.com/zdharma-continuum/zinit.git "$zinit_home"
        print_success "Zinit installed"
    else
        print_status "Zinit is already installed"
    fi
}

# Install FZF from git (for latest version)
install_fzf() {
    print_status "Installing FZF from git..."
    
    if [[ ! -d "$HOME/.fzf" ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
        print_success "FZF installed from git"
    else
        print_status "FZF is already installed"
    fi
}

# Install TPM (Tmux Plugin Manager)
install_tpm() {
    print_status "Installing TPM (Tmux Plugin Manager)..."
    
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    
    if [[ ! -d "$tpm_dir" ]]; then
        mkdir -p "$HOME/.tmux/plugins"
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        print_success "TPM installed"
    else
        print_status "TPM is already installed"
    fi
}

# Install Lua Language Server
install_lua_lsp() {
    print_status "Installing Lua Language Server..."
    
    if ! command -v lua-language-server >/dev/null 2>&1; then
        print_status "Installing lua-language-server via Homebrew..."
        if ! brew install lua-language-server 2>/dev/null; then
            print_warning "Failed to install lua-language-server via Homebrew"
            print_warning "You may need to install it manually"
        else
            print_success "Lua Language Server installed"
        fi
    else
        print_status "Lua Language Server is already installed"
    fi
}

# Install stylua (Lua formatter)
install_stylua() {
    print_status "Installing stylua (Lua formatter)..."
    
    if ! command -v stylua >/dev/null 2>&1; then
        print_status "Installing stylua via Homebrew..."
        if ! brew install stylua 2>/dev/null; then
            print_warning "Failed to install stylua via Homebrew"
            print_warning "You may need to install it manually"
        else
            print_success "stylua installed"
        fi
    else
        print_status "stylua is already installed"
    fi
}

# Post-installation setup
post_install_setup() {
    print_status "Performing post-installation setup..."
    
    # Change default shell to zsh if not already set (though macOS uses zsh by default now)
    if [[ "$SHELL" != */zsh ]]; then
        print_status "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh (restart required)"
    else
        print_status "Default shell is already zsh"
    fi
    
    # Create necessary directories
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.config"
    
    # Ensure /opt/homebrew/bin is in PATH for Apple Silicon Macs
    if [[ -d "/opt/homebrew/bin" ]] && [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
        print_status "Adding Homebrew to PATH for current session"
        export PATH="/opt/homebrew/bin:$PATH"
    fi
    
    print_success "Post-installation setup completed"
}

# Main execution
main() {
    print_status "Starting macOS dotfiles dependencies installation..."
    
    # Check prerequisites
    check_macos
    
    # Install Homebrew if not present
    if ! check_homebrew; then
        install_homebrew
    fi
    
    # Update Homebrew
    update_homebrew
    
    # Install packages
    install_homebrew_packages
    install_gui_applications
    install_fonts
    
    # Configure tools
    install_node_tools
    install_catppuccin_bat
    configure_rust
    install_lua_lsp
    install_stylua
    
    # Install additional tools
    install_zinit
    install_fzf
    install_tpm
    
    # Post-installation setup
    post_install_setup
    
    print_success "All dependencies installed successfully!"
    print_status "You can now run 'make stow' to set up your dotfiles."
    print_warning "Note: You may need to restart your terminal for all changes to take effect."
    print_warning "GUI applications have been installed to $HOME/Applications"
}

# Run main function
main "$@"
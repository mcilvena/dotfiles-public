#!/bin/bash
# Neovim Dependencies Installer for Ubuntu/WSL2
# Installs remaining language servers and tools for optimal Neovim experience

set -e  # Exit on any error

echo "🚀 Installing remaining Neovim dependencies..."
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root. Run as your regular user."
   exit 1
fi

# Update package list
print_status "Updating package list..."
sudo apt update

# Install system packages
print_status "Installing system packages..."

# Check and install lua-language-server
if ! command -v lua-language-server &> /dev/null; then
    print_status "Installing lua-language-server..."
    sudo apt install -y lua-language-server
    print_success "lua-language-server installed"
else
    print_success "lua-language-server already installed"
fi

# Check and install chafa (image preview)
if ! command -v chafa &> /dev/null; then
    print_status "Installing chafa (image preview tool)..."
    sudo apt install -y chafa
    print_success "chafa installed"
else
    print_success "chafa already installed"
fi

# Install Node.js language servers and tools
print_status "Installing Node.js language servers and tools..."

# TypeScript (required for ts_ls)
if ! command -v tsc &> /dev/null; then
    print_status "Installing TypeScript..."
    npm install -g typescript
    print_success "TypeScript installed"
else
    print_success "TypeScript already installed"
fi

# TypeScript Language Server
if ! command -v typescript-language-server &> /dev/null; then
    print_status "Installing TypeScript Language Server..."
    npm install -g typescript-language-server
    print_success "TypeScript Language Server installed"
else
    print_success "TypeScript Language Server already installed"
fi

# ESLint Language Server
if ! npm list -g eslint &> /dev/null; then
    print_status "Installing ESLint..."
    npm install -g eslint
    print_success "ESLint installed"
else
    print_success "ESLint already installed"
fi

# JSON Language Server
if ! npm list -g vscode-langservers-extracted &> /dev/null; then
    print_status "Installing JSON/CSS/HTML Language Servers..."
    npm install -g vscode-langservers-extracted
    print_success "vscode-langservers-extracted installed"
else
    print_success "vscode-langservers-extracted already installed"
fi

# YAML Language Server
if ! npm list -g yaml-language-server &> /dev/null; then
    print_status "Installing YAML Language Server..."
    npm install -g yaml-language-server
    print_success "YAML Language Server installed"
else
    print_success "YAML Language Server already installed"
fi

# Tailwind CSS Language Server
if ! npm list -g @tailwindcss/language-server &> /dev/null; then
    print_status "Installing Tailwind CSS Language Server..."
    npm install -g @tailwindcss/language-server
    print_success "Tailwind CSS Language Server installed"
else
    print_success "Tailwind CSS Language Server already installed"
fi

# Tree-sitter CLI
if ! command -v tree-sitter &> /dev/null; then
    print_status "Installing tree-sitter CLI..."
    npm install -g tree-sitter-cli
    print_success "tree-sitter CLI installed"
else
    print_success "tree-sitter CLI already installed"
fi

# Install additional build tools if missing
print_status "Checking for build essentials..."
if ! dpkg -l | grep -q build-essential; then
    print_status "Installing build-essential..."
    sudo apt install -y build-essential
    print_success "build-essential installed"
else
    print_success "build-essential already installed"
fi

echo
print_success "🎉 Installation complete!"
echo
echo "📋 Installed tools:"
echo "  ✅ lua-language-server (Lua LSP)"
echo "  ✅ chafa (image preview)"
echo "  ✅ TypeScript & TypeScript Language Server"
echo "  ✅ ESLint Language Server"
echo "  ✅ JSON/CSS/HTML Language Servers"
echo "  ✅ YAML Language Server"
echo "  ✅ Tailwind CSS Language Server"
echo "  ✅ tree-sitter CLI (grammar development)"
echo "  ✅ build-essential (compilation tools)"
echo
echo "🔄 Next steps:"
echo "  1. Restart Neovim to reload configuration"
echo "  2. Open a TypeScript/React file to test LSP features"
echo "  3. Run ':checkhealth' in Neovim to verify everything works"
echo
print_success "Your Neovim environment is now fully optimized for Next.js development!"
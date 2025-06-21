#=============================================================================
# Shell Initialization
#=============================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
OS=$(uname)

# OS-specific initialization
case $OS in
    "Darwin")
        # macOS specific setup - handle both Intel and Apple Silicon
        if [ -f "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -f "/usr/local/bin/brew" ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        ;;
    "Linux")
        # Linux specific setup
        if [ -f "/etc/os-release" ]; then
            . "/etc/os-release"
        fi
        
        # 1Password SSH agent (Arch Linux)
        if [[ -f "/etc/arch-release" ]] && [[ -S "$HOME/.1password/agent.sock" ]]; then
            export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
        fi
        ;;
esac

# Enable instant prompt if available
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#=============================================================================
# Environment Variables
#=============================================================================

# Terminal settings
export TERM=xterm-256color
export EDITOR=nvim
export VISUAL=nvim

# Theme settings
export BAT_THEME="Catppuccin Mocha"

#=============================================================================
# PATH Configuration
#=============================================================================

# Function to add to PATH if not already present
add_to_path() {
    local new_path="$1"
    case ":$PATH:" in
        *":$new_path:"*) ;;
        *) export PATH="$new_path:$PATH" ;;
    esac
}

# Add common paths
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "/opt/nvim/bin"

# OS-specific paths
case $OS in
    "Darwin")
        # macOS - handle both Intel and Apple Silicon
        add_to_path "/opt/homebrew/bin"  # Apple Silicon
        add_to_path "/usr/local/bin"     # Intel Mac
        add_to_path "/opt/homebrew/opt/rustup/bin"
        ;;
    "Linux")
        # Detect WSL
        if [[ -n "${WSL_DISTRO_NAME}" ]] || [[ "$(uname -r)" == *microsoft* ]]; then
            # WSL-specific paths
            add_to_path "/mnt/c/Windows/System32"
        fi
        
        # Distribution-specific
        if [[ -f "/etc/arch-release" ]]; then
            # Arch Linux specific
            add_to_path "/usr/bin"
        elif [[ -f "/etc/debian_version" ]]; then
            # Ubuntu/Debian specific  
            add_to_path "/usr/local/bin"
            add_to_path "/snap/bin"
        fi
        ;;
esac

# Package manager paths
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#=============================================================================
# Shell Features
#=============================================================================

# History configuration
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# History options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#=============================================================================
# Plugin Management
#=============================================================================

# Zinit setup with error handling
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" || {
        echo "Failed to clone zinit repository"
        return 1
    }
fi

# Source zinit with error handling
if [ -f "${ZINIT_HOME}/zinit.zsh" ]; then
    source "${ZINIT_HOME}/zinit.zsh"
else
    echo "zinit.zsh not found"
    return 1
fi

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Centralized completion initialization
typeset -U fpath  # Remove duplicates automatically

# Add brew completions if available
if type brew &>/dev/null; then
    fpath=($(brew --prefix)/share/zsh-completions $fpath)
fi

# Add Docker completions if available
if [[ -d "$HOME/.docker/completions" ]]; then
    fpath=($HOME/.docker/completions $fpath)
fi

# Initialize completion system once
autoload -Uz compinit
compinit -i -d ~/.zcompdump

zinit cdreplay -q

#=============================================================================
# Modern Tool Completions
#=============================================================================

# Enhanced completion setup for development tools
setup_completions() {
    local comp_dir="$HOME/.local/share/zsh/completions"
    mkdir -p "$comp_dir"
    
    # Rust toolchain
    if command -v rustup >/dev/null 2>&1; then
        rustup completions zsh > "$comp_dir/_rustup"
        rustup completions zsh cargo > "$comp_dir/_cargo"
    fi
    
    # Kubernetes & containers
    command -v kubectl >/dev/null 2>&1 && kubectl completion zsh > "$comp_dir/_kubectl"
    command -v eksctl >/dev/null 2>&1 && eksctl completion zsh > "$comp_dir/_eksctl"
    command -v docker >/dev/null 2>&1 && docker completion zsh > "$comp_dir/_docker"
    
    # AWS tools
    if command -v aws >/dev/null 2>&1; then
        aws_completer_path=$(which aws_completer 2>/dev/null)
        [[ -n "$aws_completer_path" ]] && complete -C "$aws_completer_path" aws
    fi
    
    # JavaScript package managers
    command -v pnpm >/dev/null 2>&1 && pnpm install-completion >/dev/null 2>&1
    
    # Add completion directory to fpath
    fpath=("$comp_dir" $fpath)
}

# Set up modern tool completions
setup_completions

# Smart package manager runner
run() {
    if [[ -f pnpm-lock.yaml ]]; then
        command pnpm "$@"
    elif [[ -f yarn.lock ]]; then
        command yarn "$@"
    elif [[ -f package-lock.json ]]; then
        command npm "$@"
    else
        command pnpm "$@"  # Default to pnpm
    fi
}

#=============================================================================
# Tool Initialization
#=============================================================================

# Initialize zoxide with error handling
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Initialize fzf with error handling
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# Configure fd for fzf
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

    _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
    }

    _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
    }
fi

#=============================================================================
# Development Tools
#=============================================================================

# Node.js configuration with error handling
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
    # Yarn configuration (only if nvm is loaded)
    if command -v yarn >/dev/null 2>&1; then
        export PATH="$PATH:$(yarn global bin 2>/dev/null || echo '')"
    fi
fi

# AWS authentication
AWS_AUTH_SCRIPT="${AWS_AUTH_SCRIPT:-$HOME/code/aws-auth-bash/auth.sh}"
if [ -f "$AWS_AUTH_SCRIPT" ]; then
    function awsauth {
        "$AWS_AUTH_SCRIPT" "$@"
        [[ -r "$HOME/.aws/sessiontoken" ]] && . "$HOME/.aws/sessiontoken"
    }
fi

#=============================================================================
# Local Configuration
#=============================================================================

# Load aliases with error handling
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# Load local environment variables
load_env() {
    if [[ -s ~/.env ]]; then
        env_vars=$(grep -v '^#' ~/.env | grep -v '^$')
        [[ -n "$env_vars" ]] && export $(echo "$env_vars" | xargs)
    else
        echo "No .env file found at ~/.env"
    fi
}

# Call the function in your .zshrc
load_env

# Dir env variables
eval "$(direnv hook zsh)"

# Load Powerlevel10k configuration
if [ -f ~/.p10k.zsh ]; then
    source ~/.p10k.zsh
fi

# Docker CLI completions are now handled in the centralized completion section above

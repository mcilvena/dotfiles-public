#!/bin/bash

# Sync Wezterm config from dotfiles to Windows location
# This ensures the Windows version stays in sync with the dotfiles managed version
# Only runs when in WSL environment

# Check if we're in WSL
if [[ ! -f /proc/version ]] || ! grep -q "microsoft\|WSL" /proc/version; then
    echo "This script only runs in WSL environment"
    exit 0
fi

DOTFILES_CONFIG="${DOTFILES_ROOT:-$HOME/dotfiles}/src/.wezterm.lua"
WINDOWS_CONFIG="/mnt/c/Users/${WINDOWS_USER:-$USER}/.wezterm.lua"

if [ ! -f "$DOTFILES_CONFIG" ]; then
    echo "Error: Dotfiles Wezterm config not found at $DOTFILES_CONFIG"
    exit 1
fi

if [ ! -d "$(dirname "$WINDOWS_CONFIG")" ]; then
    echo "Error: Windows user directory not accessible"
    exit 1
fi

echo "Syncing Wezterm config from dotfiles to Windows..."
cp "$DOTFILES_CONFIG" "$WINDOWS_CONFIG"

if [ $? -eq 0 ]; then
    echo "✅ Wezterm config synced successfully"
else
    echo "❌ Failed to sync Wezterm config"
    exit 1
fi

#!/bin/bash

# Wallpaper Restore Script for Hyprland
# Restores the last selected wallpaper on startup

CONFIG_DIR="$HOME/.config/hypr"
CURRENT_FILE="$CONFIG_DIR/wallpaper-current.txt"

# Wait for hyprpaper to be ready
sleep 2

# Check if current wallpaper file exists and contains a path
if [[ -f "$CURRENT_FILE" ]] && [[ -s "$CURRENT_FILE" ]]; then
    wallpaper=$(cat "$CURRENT_FILE")
    
    # Verify the wallpaper file exists
    if [[ -f "$wallpaper" ]]; then
        echo "Restoring wallpaper: $wallpaper"
        
        # Preload the wallpaper
        hyprctl hyprpaper preload "$wallpaper"
        
        # Apply to all monitors
        hyprctl monitors -j | jq -r '.[].name' | while read -r monitor; do
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
        done
        
        echo "Wallpaper restored successfully"
    else
        echo "Warning: Saved wallpaper file not found: $wallpaper"
    fi
else
    echo "No saved wallpaper to restore"
fi
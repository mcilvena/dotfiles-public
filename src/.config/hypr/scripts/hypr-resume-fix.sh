#!/bin/bash
# Hyprland monitor fix for suspend/resume
# This script reinitializes monitors after system resume

case $1/$2 in
  pre/suspend|pre/hibernate)
    echo "Preparing for suspend..."
    ;;
  post/suspend|post/hibernate)
    echo "Resuming from suspend - reinitializing monitors..."
    
    # Wait for graphics system to stabilize
    sleep 2
    
    # Find the user running Hyprland
    HYPR_USER=$(ps aux | grep '[h]yprland' | awk '{print $1}' | head -1)
    
    if [ -n "$HYPR_USER" ]; then
        # Get the Hyprland instance info
        HYPR_INSTANCE=$(ls /tmp/hypr/ 2>/dev/null | head -1)
        
        if [ -n "$HYPR_INSTANCE" ]; then
            # Reload monitor configuration
            sudo -u "$HYPR_USER" HYPRLAND_INSTANCE_SIGNATURE="$HYPR_INSTANCE" hyprctl reload
            sleep 1
            
            # Force monitor re-detection and re-enable
            sudo -u "$HYPR_USER" HYPRLAND_INSTANCE_SIGNATURE="$HYPR_INSTANCE" hyprctl keyword monitor "DP-2, 3840x2160@60, 0x490, 1.5"
            sudo -u "$HYPR_USER" HYPRLAND_INSTANCE_SIGNATURE="$HYPR_INSTANCE" hyprctl keyword monitor "DP-3, 3840x2160@60, auto-right, 1.5, transform, 1"
            
            echo "Monitor configuration reloaded for user $HYPR_USER"
        else
            echo "No Hyprland instance found"
        fi
    else
        echo "No Hyprland process found"
    fi
    ;;
esac
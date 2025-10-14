#!/bin/bash

# Rofi Power Modi Script
# This script provides power options as a rofi modi (custom mode)
# It can be used with rofi -show combi to integrate with other modi

# If no argument is provided, output the list of options
if [ -z "$1" ]; then
    echo "🔒 Lock"
    echo "🚪 Logout"
    echo "💤 Suspend"
    echo "🔄 Reboot"
    echo "⏻ Shutdown"
else
    # An option was selected, execute the corresponding action
    case "$1" in
        "🔒 Lock")
            hyprlock
            ;;
        "🚪 Logout")
            ~/.config/hypr/scripts/logout-handler.sh
            ;;
        "💤 Suspend")
            systemctl suspend
            ;;
        "🔄 Reboot")
            systemctl reboot
            ;;
        "⏻ Shutdown")
            systemctl poweroff
            ;;
    esac
fi

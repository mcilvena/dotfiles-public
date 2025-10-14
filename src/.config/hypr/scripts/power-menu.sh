#!/bin/bash

# Walker Power Menu Script
# Catppuccin Mocha themed power options

options="🔒 Lock Screen
🚪 Logout  
💤 Suspend
🔄 Reboot
⚡ Shutdown"

selected=$(echo "$options" | walker --dmenu --theme catppuccin --placeholder "Select power option...")

case $selected in
    "🔒 Lock Screen")
        hyprlock
        ;;
    "🚪 Logout")
        hyprctl dispatch exit
        ;;
    "💤 Suspend")
        systemctl suspend
        ;;
    "🔄 Reboot")
        systemctl reboot
        ;;
    "⚡ Shutdown")
        systemctl poweroff
        ;;
esac
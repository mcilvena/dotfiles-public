#!/bin/bash

# Rofi Power Menu with Simple Text

options="Lock\nLogout\nSuspend\nReboot\nShutdown"

selected=$(echo -e "$options" | XCURSOR_SIZE=24 rofi -dmenu -p "Power" -theme catppuccin-clean -click-to-exit)

case $selected in
    "Lock")
        hyprlock
        ;;
    "Logout")
        ~/.config/hypr/scripts/logout-handler.sh
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
esac
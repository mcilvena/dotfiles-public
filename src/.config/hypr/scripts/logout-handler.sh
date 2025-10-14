#!/bin/bash
# Logout Handler for Hyprland
# Safely prepares monitors before logging out to prevent "input not supported" errors

# Log file for debugging
LOG_FILE="$HOME/.config/hypr/logs/monitor-reset.log"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - LOGOUT: $1" | tee -a "$LOG_FILE"
}

log "Starting logout sequence..."

# Call monitor-reset script in safe-disable mode
log "Preparing monitors for logout..."
"$HOME/.config/hypr/scripts/monitor-reset.sh" safe-disable

# Small delay to ensure monitors are in safe state
sleep 1

# Now safely exit Hyprland
log "Exiting Hyprland..."
hyprctl dispatch exit

log "Logout sequence completed"

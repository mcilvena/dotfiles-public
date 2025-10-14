#!/bin/bash
# Monitor Reset Script for Hyprland
# Fixes "input not supported" issues after suspend/resume

# Log file for debugging
LOG_FILE="$HOME/.config/hypr/logs/monitor-reset.log"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Parse command line arguments
MODE="${1:-reset}"  # Default to 'reset' mode if no argument provided

log "Starting monitor $MODE..."

# Safe disable mode - for pre-logout or pre-sleep
if [ "$MODE" = "safe-disable" ]; then
    log "Safe disable mode - removing transforms and preparing for shutdown..."

    # Apply monitors without transforms first
    log "Removing transforms temporarily..."
    hyprctl keyword monitor "DP-2,3840x2160@60,0x490,1"
    hyprctl keyword monitor "DP-3,3840x2160@60,auto-right,1"
    sleep 1

    # Now safely disable DPMS
    log "Disabling DPMS..."
    hyprctl dispatch dpms off
    sleep 1

    log "Safe disable completed"
    exit 0
fi

# Normal reset mode
# Wait for Hyprland to be ready
sleep 2

# Force DPMS on for all monitors
log "Enabling DPMS for all monitors..."
hyprctl dispatch dpms on

# Longer delay to allow LG monitors to fully wake up and initialize
log "Waiting for monitors to fully initialize..."
sleep 3

# Re-source the monitor configuration from monitors.conf
MONITORS_CONF="$HOME/.config/hypr/conf/monitors.conf"

if [ ! -f "$MONITORS_CONF" ]; then
    log "Error: monitors.conf not found at $MONITORS_CONF"
    exit 1
fi

log "Reloading monitor configuration from $MONITORS_CONF..."

# Extract monitor lines from the config file and apply them
grep "^monitor = " "$MONITORS_CONF" | while read -r line; do
    # Remove "monitor = " prefix and apply the configuration
    monitor_config=$(echo "$line" | sed 's/^monitor = //')
    log "Applying: $monitor_config"
    hyprctl keyword monitor "$monitor_config"
done

# Additional delay for monitor stabilization
sleep 2

# Verify monitors are working
ACTIVE_MONITORS=$(hyprctl monitors -j | jq -r '.[] | select(.disabled == false) | .name')
log "Active monitors after reset: $(echo "$ACTIVE_MONITORS" | tr '\n' ' ')"

# Force a compositor refresh
log "Refreshing compositor..."
hyprctl dispatch exec "sleep 0.1"

log "Monitor reset completed"
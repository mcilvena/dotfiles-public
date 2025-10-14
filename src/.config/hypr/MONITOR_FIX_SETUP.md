# Monitor Fix Setup Instructions

This solution fixes "input not supported" issues on LG displays during suspend/resume, logout, and idle timeout in Hyprland.

## Setup Steps

### 1. Install the udev rules (requires sudo)
Run this command to install the udev rules:
```bash
sudo cp ~/dotfiles/src/etc/udev/rules.d/99-monitor-hotplug.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### 2. Enable and start the systemd service
```bash
systemctl --user enable --now hyprland-monitor-reset.service
```

### 3. Make scripts executable
```bash
chmod +x ~/.config/hypr/scripts/monitor-reset.sh
chmod +x ~/.config/hypr/scripts/logout-handler.sh
```

### 4. Reload Hyprland configuration
```bash
hyprctl reload
```

### 5. Restart hypridle (if running)
```bash
pkill hypridle && hypridle &
```

## How It Works

### Monitor Reset Modes

The system now uses two modes to prevent "input not supported" errors:

1. **Safe-Disable Mode** - Removes monitor transforms and scaling before power state changes
   - Called before logout
   - Called before system suspend/hibernate
   - Called before idle DPMS timeout
   - Prevents LG displays from receiving invalid signals during transitions

2. **Reset Mode** (default) - Fully reinitializes monitors
   - Called after system resume
   - Called when waking from idle
   - Includes 3-second delay for LG monitors to fully initialize
   - Reapplies full configuration with scaling and rotation

### Automatic Triggers

- **Resume**: systemd service + hypridle reset monitors after suspend/hibernate
- **Logout**: Custom logout handler safely disables monitors before exiting Hyprland
- **Idle Wake**: hypridle resets monitors when activity is detected
- **Hotplug**: udev rules detect DisplayPort connection changes
- **Manual**: Press `Super + Ctrl + Shift + M` to manually reset monitors
- **Logging**: Check `~/.config/hypr/logs/monitor-reset.log` for troubleshooting

## Testing

1. **Test manual reset**: `Super + Ctrl + Shift + M`
2. **Test logout**: Use power menu (`Super + Shift + Q`) and select Logout
3. **Test suspend/resume**: `systemctl suspend` then wake your system
4. **Test idle wake**: Let system go to sleep (wait 15+ minutes), then wake it
5. **Test safe-disable mode**: `~/.config/hypr/scripts/monitor-reset.sh safe-disable`

## Troubleshooting

If monitors still have issues:

1. **Check the log file**: `~/.config/hypr/logs/monitor-reset.log`
   - Look for errors during safe-disable or reset operations
   - Check timing between DPMS commands and monitor reconfigurations

2. **Verify monitor names**: `hyprctl monitors`
   - Ensure DP-2 and DP-3 are detected
   - Update monitor names in scripts if different

3. **Test scripts manually**:
   - Reset mode: `~/.config/hypr/scripts/monitor-reset.sh`
   - Safe-disable mode: `~/.config/hypr/scripts/monitor-reset.sh safe-disable`
   - Logout handler: `~/.config/hypr/scripts/logout-handler.sh`

4. **Check systemd service status**: `systemctl --user status hyprland-monitor-reset.service`

5. **Verify hypridle is running**: `pgrep hypridle`

6. **Monitor configuration**: Update `~/.config/hypr/conf/monitors.conf` if needed

### Known Issues with LG Displays

- LG displays are strict about input validation during power transitions
- Transform (rotation) + scaling during DPMS changes can trigger "input not supported"
- Solution: Safe-disable mode removes transforms before power state changes
- 3-second initialization delay ensures monitors are fully ready before reconfiguration

The scripts automatically read your current monitor configuration from `monitors.conf`, so they stay in sync with any changes you make.
# Hyprland Configuration - Enhanced 2025 Edition

![Hyprland Screenshot](https://raw.githubusercontent.com/mcilvena/dotfiles-public/main/assets/hypr-screenshot.png)

## Overview

This is a modular, performance-optimized Hyprland configuration featuring:

- **Catppuccin Mocha theme** with enhanced visual effects
- **2025 performance optimizations** for modern hardware
- **Modular configuration structure** for easy maintenance
- **Advanced keybindings** with submaps and quality-of-life features

## Configuration Structure

```
~/.config/hypr/
├── hyprland.conf          # Main configuration file
├── conf/                  # Modular configuration directory
│   ├── monitors.conf      # Monitor and workspace setup
│   ├── environment.conf   # Environment variables and theme colors
│   ├── autostart.conf     # Startup applications
│   ├── input.conf         # Keyboard, mouse, touchpad settings
│   ├── appearance.conf    # Visual styling and effects
│   ├── animations.conf    # Animation configurations
│   ├── layouts.conf       # Window layouts and gestures
│   ├── windowrules.conf   # Application-specific window rules
│   └── keybinds.conf      # All keybindings and shortcuts
├── backup/                # Backup of previous configuration
├── KEY_BINDINGS.md        # Comprehensive keybinding reference
├── hyprpaper.conf         # Wallpaper configuration
└── README.md              # This file
```

## Key Features

### Performance Optimizations

- **Explicit Sync**: Hardware-accelerated rendering with NVIDIA optimizations
- **VRR/FreeSync**: Variable refresh rate support
- **Smart Blur**: Optimized blur effects with minimal performance impact
- **Direct Scanout**: Reduced latency for fullscreen applications

### Quality of Life Improvements

- **Resize Mode**: Precision window resizing with `SUPER + R`
- **Power Menu**: Quick system controls with `SUPER + SHIFT + Escape`
- **Window Grouping**: Tab-like window management
- **Smart Snapping**: Instant window arrangement with `SUPER_ALT + Arrow Keys`
- **Clipboard History**: Persistent clipboard with search (`SUPER + V`)
- **Scratchpad**: Quick access terminal overlay

### Visual Enhancements

- **Enhanced Animations**: Smooth bezier curves for natural motion
- **Dynamic Opacity**: Context-aware window transparency
- **Smart Shadows**: Proper depth perception with optimized rendering
- **Rounded Corners**: 8px corners with improved anti-aliasing

## Hardware Support

### Monitor Setup

- **Dual 4K monitors** at 60Hz with 1.5x scaling
- **Portrait mode support** for secondary monitor
- **Workspace distribution** across monitors (1-5 on primary, 6-10 on secondary)

### NVIDIA Optimizations

- Proper environment variables for Wayland compatibility
- Hardware cursor workarounds
- VRR and G-Sync support
- Anti-flicker optimizations

## Quick Start

1. **Backup your existing configuration** (if any):

   ```bash
   mv ~/.config/hypr ~/.config/hypr.backup
   ```

2. **This configuration is already active** - your backup is in `~/.config/hypr/backup/`

3. **Test the new features**:

   - Try `SUPER + R` for resize mode
   - Use `SUPER + V` for clipboard history
   - Test `SUPER + SHIFT + Escape` for power menu

4. **Customize as needed**:
   - Edit files in `conf/` directory for specific changes
   - Colors are defined in `conf/environment.conf`
   - Keybindings are in `conf/keybinds.conf`

## Essential Applications

This configuration works best with these applications:

- **Terminal**: alacritty (default)
- **Launcher**: rofi
- **File Manager**: thunar
- **Screenshots**: grimblast
- **Wallpapers**: hyprpaper
- **Panel**: HyprPanel (AGS-based, replaces waybar)
- **Lock Screen**: hyprlock
- **Clipboard**: cliphist + wl-clipboard

### HyprPanel Setup

HyprPanel replaces both waybar and dunst with a modern, integrated solution:

- **Installation**: `yay -S ags-hyprpanel-git` + dependencies
- **Configuration**: `~/.config/ags/config.js`
- **Features**: Workspaces, system tray, volume, battery, network, clock
- **Theme**: Integrated Catppuccin Mocha styling

## Customization

### Changing Colors

Edit `conf/environment.conf` to modify the Catppuccin color palette.

### Adding Keybindings

Add new bindings to `conf/keybinds.conf` following the existing patterns.

### Window Rules

Modify `conf/windowrules.conf` for application-specific behavior.

### Monitor Configuration

Update `conf/monitors.conf` for different monitor setups.

## Troubleshooting

### Configuration Issues

If you encounter problems:

1. Check the backup: `ls ~/.config/hypr/backup/`
2. Restore if needed: `cp -r ~/.config/hypr/backup/* ~/.config/hypr/`
3. Test individual config files with `hyprctl reload`

### Performance Issues

- Disable blur in `conf/appearance.conf` if needed
- Reduce animation complexity in `conf/animations.conf`
- Check NVIDIA driver compatibility

## Re-enabling Auto-reload

To re-enable automatic configuration reloading:

```bash
hyprctl keyword misc:disable_autoreload false
```

## Updates and Maintenance

This configuration is optimized for Hyprland 0.50+ with modern features. Regular updates may be needed as Hyprland evolves.

For the latest features and improvements, refer to:

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)

---

**Created**: July 22, 2025  
**Version**: Enhanced 2025 Edition  
**Theme**: Catppuccin Mocha  
**Hyprland Version**: 0.50+


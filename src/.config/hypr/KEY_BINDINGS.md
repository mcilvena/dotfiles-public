# Hyprland Key Bindings Reference - Enhanced 2025 Edition

This document provides a comprehensive reference for all key bindings in this enhanced Hyprland configuration.

## Key Modifiers
- `SUPER` = Windows key (main modifier)
- `SUPER_ALT` = Windows key + Alt
- `CTRL` = Control key
- `SHIFT` = Shift key

## Basic Window Controls

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + Return` | Launch Terminal | Opens alacritty terminal |
| `SUPER + Q` | Kill Active Window | Closes the focused window |
| `SUPER + SHIFT + Q` | Logout Menu | Opens wlogout menu |
| `SUPER + F` | File Manager | Opens thunar file manager |
| `SUPER + SHIFT + F` | Toggle Fullscreen | Makes active window fullscreen |
| `SUPER + SHIFT + T` | Toggle Floating | Toggles window floating mode |
| `SUPER + Space` | Application Launcher | Opens rofi launcher |
| `SUPER + P` | Pseudo Tiling | Enables pseudo tiling for window |
| `SUPER + SHIFT + V` | Toggle Split | Changes split direction |
| `SUPER + Tab` | Focus Last Window | Switches to previously focused window |
| `SUPER + Escape` | Lock Screen | Locks the screen with hyprlock |

## Window Navigation

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + h/j/k/l` | Move Focus | Vim-style directional focus |
| `SUPER + Left/Right/Up/Down` | Move Focus | Arrow key directional focus |

## Window Movement

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + SHIFT + h/j/k/l` | Move Window | Vim-style directional window movement |
| `SUPER + SHIFT + Left/Right/Up/Down` | Move Window | Arrow key directional window movement |
| `SUPER + SHIFT + C` | Center Window | Centers the active window |

## Window Resizing

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + CTRL + h/j/k/l` | Resize Window | Vim-style window resizing (±40px) |
| `SUPER + CTRL + Left/Right/Up/Down` | Resize Window | Arrow key window resizing (±40px) |
| `SUPER + R` | **Resize Mode** | Enter precision resize mode (see below) |

### Resize Mode (SUPER + R)
Once in resize mode, use these keys:
- `h/j/k/l` or `Left/Right/Up/Down` - Fine resize (±20px)
- `Escape` or `Return` - Exit resize mode

## Workspace Management

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + 1-9,0` | Switch Workspace | Go to workspace 1-10 |
| `SUPER + SHIFT + 1-9,0` | Move to Workspace | Move active window to workspace 1-10 |
| `SUPER + CTRL + 1-9,0` | Move Silent | Move window without following |
| `SUPER + ]` | Next Workspace | Go to next workspace |
| `SUPER + [` | Previous Workspace | Go to previous workspace |
| `SUPER_ALT + l` | Next Workspace | Alternative next workspace |
| `SUPER_ALT + h` | Previous Workspace | Alternative previous workspace |
| `SUPER + Mouse Wheel` | Cycle Workspaces | Scroll through workspaces |

## Special Workspaces (Scratchpad)

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + ~` | Toggle Scratchpad | Show/hide scratchpad workspace |
| `SUPER + SHIFT + ~` | Move to Scratchpad | Move window to scratchpad |

## Screenshots (Enhanced)

| Key Combination | Action | Description |
|---|---|---|
| `Print` | Screenshot Area | Copy selected area to clipboard |
| `SHIFT + Print` | Save Screenshot Area | Save selected area to ~/Pictures/Screenshots/ |
| `CTRL + Print` | Screenshot Screen | Copy entire screen to clipboard |
| `SUPER + Print` | Screenshot Window | Copy active window to clipboard |
| `SUPER + SHIFT + S` | Advanced Screenshot | Copy and save area screenshot |

## Audio & Media Controls

| Key Combination | Action | Description |
|---|---|---|
| `XF86AudioRaiseVolume` | Volume Up | Increase volume by 5% (max 140%) |
| `XF86AudioLowerVolume` | Volume Down | Decrease volume by 5% |
| `XF86AudioMute` | Toggle Mute | Mute/unmute audio |
| `XF86AudioPlay` | Play/Pause | Toggle media playback |
| `XF86AudioNext` | Next Track | Skip to next track |
| `XF86AudioPrev` | Previous Track | Skip to previous track |
| `XF86AudioStop` | Stop | Stop media playback |

## Brightness Controls

| Key Combination | Action | Description |
|---|---|---|
| `XF86MonBrightnessUp` | Brightness Up | Increase screen brightness by 10% |
| `XF86MonBrightnessDown` | Brightness Down | Decrease screen brightness by 10% |

## Quick Application Launch

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + B` | Browser | Launch Firefox |
| `SUPER + SHIFT + E` | Code Editor | Launch VS Code |
| `SUPER + SHIFT + M` | Music | Launch Spotify |
| `SUPER + SHIFT + D` | Chat | Launch Discord |
| `SUPER + SHIFT + A` | File Manager | Alternative file manager launch |

## Advanced Window Management

### Preset Window Sizes
| Key Combination | Action | Description |
|---|---|---|
| `SUPER_ALT + 1` | 33% Width | Resize window to 1/3 screen width |
| `SUPER_ALT + 2` | 50% Width | Resize window to 1/2 screen width |
| `SUPER_ALT + 3` | 67% Width | Resize window to 2/3 screen width |
| `SUPER_ALT + 4` | 75% Width | Resize window to 3/4 screen width |

### Smart Window Snapping
| Key Combination | Action | Description |
|---|---|---|
| `SUPER_ALT + Left` | Snap Left | Move and resize to left half of screen |
| `SUPER_ALT + Right` | Snap Right | Move and resize to right half of screen |
| `SUPER_ALT + Up` | Snap Top | Move and resize to top half of screen |
| `SUPER_ALT + Down` | Snap Bottom | Move and resize to bottom half of screen |

## Window Grouping (Tabbing)

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + G` | Toggle Group | Create/dissolve window group |
| `SUPER + Tab` | Next in Group | Switch to next window in group |
| `SUPER + SHIFT + Tab` | Previous in Group | Switch to previous window in group |

## Layout Management

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + M` | Master Layout | Switch to master layout |
| `SUPER + SHIFT + M` | Dwindle Layout | Switch to dwindle layout |

## Enhanced Features

### Clipboard Management
| Key Combination | Action | Description |
|---|---|---|
| `SUPER + V` | Clipboard History | Open clipboard history with wofi |

### System Utilities
| Key Combination | Action | Description |
|---|---|---|
| `SUPER + SHIFT + P` | Color Picker | Launch hyprpicker color picker |
| `SUPER + SHIFT + Return` | Swap Windows | Swap current window with next |

### Power Management (SUPER + SHIFT + Escape)
Enter power menu mode, then:
- `s` - Suspend system
- `r` - Reboot system  
- `p` - Power off system
- `l` - Lock screen
- `Escape` - Exit power menu

## Mouse Controls

| Key Combination | Action | Description |
|---|---|---|
| `SUPER + Left Click + Drag` | Move Window | Drag window to move |
| `SUPER + Right Click + Drag` | Resize Window | Drag to resize window |

## Monitor Configuration

This configuration supports a dual-monitor setup:
- **DP-2**: Primary monitor (3840x2160@60Hz, 1.5x scaling)
- **DP-3**: Secondary monitor (3840x2160@60Hz, 1.5x scaling, rotated 90° CCW)

### Workspace Distribution
- **Workspaces 1-5**: DP-2 (Primary monitor)
- **Workspaces 6-10**: DP-3 (Secondary monitor)

## Quality of Life Features

### Performance Optimizations
- **VRR/FreeSync**: Enabled for supported monitors
- **Explicit Sync**: Hardware-accelerated rendering
- **Smart Blur**: Optimized blur effects with minimal performance impact

### Visual Enhancements  
- **Enhanced Animations**: Smooth bezier curves for natural motion
- **Smart Grouping**: Tab-like window management
- **Dynamic Opacity**: Context-aware window transparency

### Workflow Features
- **Scratchpad Terminal**: Quick access terminal overlay
- **Clipboard History**: Persistent clipboard with search
- **Auto Workspace**: Applications auto-assign to workspaces
- **Gaming Optimizations**: Low-latency mode for games

## Tips & Tricks

1. **Resize Mode**: Use `SUPER + R` for precise window resizing
2. **Power Menu**: Quick access to system controls with `SUPER + SHIFT + Escape`
3. **Workspace Switching**: Use `SUPER_ALT + h/l` for fast workspace navigation
4. **Window Grouping**: Press `SUPER + G` to tab windows together
5. **Scratchpad**: Perfect for terminals and quick notes
6. **Smart Snapping**: `SUPER_ALT + Arrow Keys` for instant window arrangement

## Theme Information

This configuration uses **Catppuccin Mocha** with:
- **12px rounded corners** with improved anti-aliasing
- **Optimized blur effects** with noise reduction
- **Smooth animations** using custom bezier curves
- **Smart transparency** (92% for inactive windows)
- **Enhanced shadows** with proper depth perception
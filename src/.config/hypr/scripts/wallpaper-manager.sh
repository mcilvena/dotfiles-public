#!/bin/bash

# Wallpaper Manager for Hyprland
# Manages wallpapers dynamically using hyprctl and hyprpaper

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CONFIG_DIR="$HOME/.config/hypr"
FAVORITES_FILE="$CONFIG_DIR/wallpaper-favorites.txt"
CURRENT_FILE="$CONFIG_DIR/wallpaper-current.txt"

# Ensure directories exist
mkdir -p "$CONFIG_DIR"
touch "$FAVORITES_FILE" "$CURRENT_FILE"

# Get list of wallpapers
get_wallpapers() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort
}

# Get current wallpaper
get_current_wallpaper() {
    if [[ -f "$CURRENT_FILE" ]]; then
        cat "$CURRENT_FILE"
    fi
}

# Set wallpaper on all monitors
set_wallpaper() {
    local wallpaper="$1"
    
    if [[ ! -f "$wallpaper" ]]; then
        echo "Error: Wallpaper file not found: $wallpaper"
        exit 1
    fi
    
    # Preload wallpaper
    hyprctl hyprpaper preload "$wallpaper"
    
    # Set on all monitors
    hyprctl monitors -j | jq -r '.[].name' | while read -r monitor; do
        hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
    done
    
    # Save current wallpaper
    echo "$wallpaper" > "$CURRENT_FILE"
    echo "Set wallpaper: $(basename "$wallpaper")"
}

# Show wallpaper selector using rofi
show_selector() {
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        notify-send "Wallpaper Manager" "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    # Create display names (just filenames)
    local display_names=()
    for wallpaper in "${wallpapers[@]}"; do
        display_names+=("$(basename "$wallpaper")")
    done
    
    # Show rofi menu
    local selected
    selected=$(printf '%s\n' "${display_names[@]}" | rofi -dmenu -i -p "Select Wallpaper" -theme-str 'window {width: 50%;}')
    
    if [[ -n "$selected" ]]; then
        # Find full path of selected wallpaper
        for wallpaper in "${wallpapers[@]}"; do
            if [[ "$(basename "$wallpaper")" == "$selected" ]]; then
                set_wallpaper "$wallpaper"
                break
            fi
        done
    fi
}

# Set random wallpaper
set_random() {
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    local random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
    set_wallpaper "$random_wallpaper"
}

# Cycle to next wallpaper
cycle_next() {
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    local current
    current=$(get_current_wallpaper)
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    # Find current wallpaper index
    local current_index=-1
    for i in "${!wallpapers[@]}"; do
        if [[ "${wallpapers[$i]}" == "$current" ]]; then
            current_index=$i
            break
        fi
    done
    
    # Get next wallpaper
    local next_index=$(( (current_index + 1) % ${#wallpapers[@]} ))
    set_wallpaper "${wallpapers[$next_index]}"
}

# Cycle to previous wallpaper
cycle_prev() {
    local wallpapers
    mapfile -t wallpapers < <(get_wallpapers)
    local current
    current=$(get_current_wallpaper)
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    # Find current wallpaper index
    local current_index=-1
    for i in "${!wallpapers[@]}"; do
        if [[ "${wallpapers[$i]}" == "$current" ]]; then
            current_index=$i
            break
        fi
    done
    
    # Get previous wallpaper
    local prev_index=$(( (current_index - 1 + ${#wallpapers[@]}) % ${#wallpapers[@]} ))
    set_wallpaper "${wallpapers[$prev_index]}"
}

# Add current wallpaper to favorites
add_favorite() {
    local current
    current=$(get_current_wallpaper)
    
    if [[ -z "$current" ]]; then
        echo "No current wallpaper set"
        exit 1
    fi
    
    if ! grep -Fxq "$current" "$FAVORITES_FILE"; then
        echo "$current" >> "$FAVORITES_FILE"
        echo "Added to favorites: $(basename "$current")"
    else
        echo "Already in favorites: $(basename "$current")"
    fi
}

# Show favorites selector
show_favorites() {
    if [[ ! -s "$FAVORITES_FILE" ]]; then
        notify-send "Wallpaper Manager" "No favorite wallpapers found"
        exit 1
    fi
    
    local favorites
    mapfile -t favorites < "$FAVORITES_FILE"
    
    # Create display names
    local display_names=()
    for wallpaper in "${favorites[@]}"; do
        if [[ -f "$wallpaper" ]]; then
            display_names+=("$(basename "$wallpaper")")
        fi
    done
    
    if [[ ${#display_names[@]} -eq 0 ]]; then
        notify-send "Wallpaper Manager" "No valid favorite wallpapers found"
        exit 1
    fi
    
    # Show rofi menu
    local selected
    selected=$(printf '%s\n' "${display_names[@]}" | rofi -dmenu -i -p "Select Favorite" -theme-str 'window {width: 50%;}')
    
    if [[ -n "$selected" ]]; then
        # Find full path of selected wallpaper
        for wallpaper in "${favorites[@]}"; do
            if [[ "$(basename "$wallpaper")" == "$selected" ]] && [[ -f "$wallpaper" ]]; then
                set_wallpaper "$wallpaper"
                break
            fi
        done
    fi
}

# Show help
show_help() {
    cat << EOF
Wallpaper Manager for Hyprland

Usage: $0 [OPTION]

Options:
    select, -s      Show wallpaper selector
    random, -r      Set random wallpaper
    next, -n        Cycle to next wallpaper
    prev, -p        Cycle to previous wallpaper
    favorite, -f    Add current wallpaper to favorites
    favorites       Show favorites selector
    current         Show current wallpaper
    help, -h        Show this help

Examples:
    $0 select       # Open wallpaper selector
    $0 random       # Set random wallpaper
    $0 next         # Next wallpaper in sequence
EOF
}

# Main script logic
case "${1:-select}" in
    "select"|"-s")
        show_selector
        ;;
    "random"|"-r")
        set_random
        ;;
    "next"|"-n")
        cycle_next
        ;;
    "prev"|"-p")
        cycle_prev
        ;;
    "favorite"|"-f")
        add_favorite
        ;;
    "favorites")
        show_favorites
        ;;
    "current")
        current=$(get_current_wallpaper)
        if [[ -n "$current" ]]; then
            echo "Current wallpaper: $(basename "$current")"
        else
            echo "No current wallpaper set"
        fi
        ;;
    "help"|"-h")
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
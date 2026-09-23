#!/bin/bash
# ==============================================================================
# Dynamic Pywal Theme Switcher for Hyprland, GTK, Qt & Quickshell
# Repository: https://github.com/ByTrist4n/pywal-theme-switcher
# Author: ByTrist4n (https://github.com/ByTrist4n)
# ==============================================================================

# Configuration paths
dir_wallpaper="$HOME/Pictures/Wallpapers"
hypr_colors="$HOME/.config/hypr/config/colors.lua"
wal_colors="$HOME/.cache/wal/colors.lua"
hooks_dir="$HOME/.config/pywal-theme-switcher/post-hooks.d"

# Select wallpaper with rofi
selected=$(find "$dir_wallpaper" -type f | while read -r line; do
  echo -e "$(basename "$line")\x00icon\x1f$line"
done | rofi -dmenu -theme ~/.config/rofi/wallpaper.rasi)

[ -z "$selected" ] && exit 0

wallpaper=$(find "$dir_wallpaper" -name "$selected" | head -n 1)

# Apply wallpaper with transition
if command -v awww &>/dev/null; then
  awww img "$wallpaper" --transition-type grow --transition-duration 1
fi

# Generate colors via wpgtk (updates oomox, pywal and Kvantum templates)
if command -v wpg &>/dev/null; then
  wpg -s "$wallpaper"
fi

# Current wallpaper
cp -f "$(cat ~/.cache/wal/wal)" ~/.cache/wal/wal_wallpaper.jpg

# Execute post-theme hooks if available
if [ -d "$hooks_dir" ]; then
  for hook in "$hooks_dir"/*; do
    [ -x "$hook" ] && "$hook"
  done
fi

# Wlogout replaces SVG fill colors with dynamic wal colors
if [ -f "$HOME/.cache/wal/colors.json" ]; then
  COLOR_WAL=$(grep -oP '"color15": "\K[^"]+' "$HOME/.cache/wal/colors.json")
  if [ -n "$COLOR_WAL" ] && [ -d "$HOME/.config/wlogout/assets/" ]; then
    find "$HOME/.config/wlogout/assets/" -name "*.svg" -exec sed -i "s/fill=\"#[0-9a-fA-F]\{6\}\"/fill=\"$COLOR_WAL\"/g" {} +
  fi
fi

# Hyprland Config colors (.lua)
if [ -f "$wal_colors" ]; then
  cp "$wal_colors" "$hypr_colors"
fi

# Refresh Hyprland
if command -v hyprctl &>/dev/null; then
  hyprctl reload
fi

# Refresh Waybar
if command -v waybar &>/dev/null; then
  pkill waybar
  waybar &
  disown
fi

# Refresh Quickshell
if command -v quickshell &>/dev/null; then
  pkill quickshell
  quickshell &
  disown
  sleep 1.5
fi

# Desktop Notification
if command -v notify-send &>/dev/null; then
  notify-send -i "$HOME/.local/share/icons/pywal-theme-switcher.svg" -a "Pywal Theme Switcher" "🎨 Theme updated successfully!" "$(basename "$wallpaper")"
fi

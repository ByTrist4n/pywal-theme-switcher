#!/usr/bin/env bash
# ==============================================================================
# Dynamic Pywal Theme Switcher for Hyprland, GTK, Qt & Quickshell
# Repository: https://github.com/ByTrist4n/pywal-theme-switcher
# Author: ByTrist4n (https://github.com/ByTrist4n)
# ==============================================================================

set -e

# Configuration paths
dir_wallpaper="$HOME/Pictures/Wallpapers"
hypr_colors="$HOME/.config/hypr/config/colors.lua"
wal_colors="$HOME/.cache/wal/colors.lua"
hooks_dir="$HOME/.local/bin/pywal-theme-switcher/post-hooks.d"
config_file="$HOME/.config/pywal-theme-switcher/config.toml"

# Default fallbacks
launcher="rofi"
enable_notifs="true"

# Parse TOML config if present
if [[ -f "$config_file" ]]; then
  # Parse launcher setting
  parsed_launcher=$(grep -E '^\s*launcher\s*=' "$config_file" | cut -d '=' -f 2 | tr -d ' "' | tr -d "'")
  [[ -n "$parsed_launcher" ]] && launcher="$parsed_launcher"

  # Parse notification setting
  parsed_notifs=$(grep -E '^\s*enable\s*=' "$config_file" | cut -d '=' -f 2 | tr -d ' "' | tr -d "'")
  [[ -n "$parsed_notifs" ]] && enable_notifs="$parsed_notifs"
fi

# Select wallpaper using chosen launcher (Walker or Rofi)
if [[ "$launcher" == "walker" ]] && command -v walker &>/dev/null; then
  selected=$(
    find "$dir_wallpaper" -type f -print0 |
      while IFS= read -r -d '' file; do
        echo "$(basename "$file")"
      done |
      walker --dmenu
  )
else
  selected=$(
    find "$dir_wallpaper" -type f -print0 |
      while IFS= read -r -d '' file; do
        echo -e "$(basename "$file")\x00icon\x1f$file"
      done |
      rofi -dmenu
  )
fi

[[ -z "$selected" ]] && exit 0

wallpaper=$(find "$dir_wallpaper" -type f -name "$selected" -print -quit)

# Apply wallpaper with transition
if command -v awww &>/dev/null; then
  awww img "$wallpaper" --transition-type grow --transition-duration 1
fi

# Generate colors via wpgtk (updates oomox, pywal and Kvantum templates)
if command -v wpg &>/dev/null; then
  wpg -s "$wallpaper"
fi

# Save current wallpaper
cp -f "$(cat "$HOME/.cache/wal/wal")" "$HOME/.cache/wal/wal_wallpaper.jpg"

# Execute post-theme hooks if available
if [[ -d "$hooks_dir" ]]; then
  for hook in "$hooks_dir"/*; do
    [[ -x "$hook" ]] && "$hook"
  done
fi

# Replace Wlogout SVG fill colors with dynamic wal colors
if [[ -f "$HOME/.cache/wal/colors.json" ]]; then
  color_wal=$(grep -oP '"color15": "\K[^"]+' "$HOME/.cache/wal/colors.json")

  if [[ -n "$color_wal" ]] && [[ -d "$HOME/.config/wlogout/assets/" ]]; then
    find "$HOME/.config/wlogout/assets/" \
      -name "*.svg" \
      -exec sed -i "s/fill=\"#[0-9a-fA-F]\{6\}\"/fill=\"$color_wal\"/g" {} +
  fi
fi

# Hyprland Config colors (.lua)
if [[ -f "$wal_colors" ]]; then
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
if [[ "$enable_notifs" == "true" ]] && command -v notify-send &>/dev/null; then
  notify-send \
    -i "$HOME/.local/share/icons/pywal-theme-switcher.svg" \
    -a "Pywal Theme Switcher" \
    "🎨 Theme updated successfully!" \
    "$(basename "$wallpaper")"
fi

#!/usr/bin/env bash
# ==============================================================================
# Dynamic Pywal Theme Switcher for Hyprland, GTK, Qt & Quickshell
# Repository: https://github.com/ByTrist4n/pywal-theme-switcher
# Author: ByTrist4n
# ==============================================================================

set -e
source "./utils.sh"

clear

echo "──────────────────────────────────────────────────────────────────────"
echo ""
echo "██████╗ ██╗   ██╗██╗    ██╗ █████╗ ██╗                        "
echo "██╔══██╗╚██╗ ██╔╝██║    ██║██╔══██╗██║                        "
echo "██████╔╝ ╚████╔╝ ██║ █╗ ██║███████║██║                        "
echo "██╔═══╝   ╚██╔╝  ██║███╗██║██╔══██║██║                        "
echo "██║        ██║   ╚███╔███╔╝██║  ██║███████╗                   "
echo "╚═╝        ╚═╝    ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝                   "
echo ""
echo "████████╗██╗  ██╗███████╗███╗   ███╗███████╗                  "
echo "╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝                  "
echo "   ██║   ███████║█████╗  ██╔████╔██║█████╗                    "
echo "   ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝                    "
echo "   ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗                  "
echo "   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝                  "
echo ""
echo "███████╗██╗    ██╗██╗████████╗ ██████╗██╗  ██╗███████╗██████╗ "
echo "██╔════╝██║    ██║██║╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗"
echo "███████╗██║ █╗ ██║██║   ██║   ██║     ███████║█████╗  ██████╔╝"
echo "╚════██║██║███╗██║██║   ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗"
echo "███████║╚███╔███╔╝██║   ██║   ╚██████╗██║  ██║███████╗██║  ██║"
echo "╚══════╝ ╚══╝╚══╝ ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo ""
echo "Welcome to the installation script for \"Pywal Theme Switcher\""
echo ""
echo "⭐ If you like it, drop a star! It helps a lot 🫰💖"
echo "https://github.com/ByTrist4n/pywal-theme-switcher"
echo ""
echo "──────────────────────────────────────────────────────────────────────"

dir_dot_conf="$HOME/.config"
dir_local_bin="$HOME/.local/bin"
dir_local_apps="$HOME/.local/share/applications"
dir_local_icons="$HOME/.local/share/icons"
dir_hypr="$dir_dot_conf/hypr"
dir_hypr_conf="$dir_hypr/hyprland.lua"
dir_hypr_colors="$dir_hypr/config"
dir_user_wallpaper="$HOME/Pictures/Wallpapers"
dir_wal="$dir_dot_conf/wal"
dir_kvantum_pywal="$dir_dot_conf/Kvantum/pywal"
dir_qt="$dir_dot_conf/qt6ct"
dir_qt6ct_colors="$dir_qt/colors"
qt6ct_conf="$dir_qt/qt6ct.conf"
kitty_conf="$dir_dot_conf/kitty/kitty.conf"

log_step "Creating directory structure..."
mkdir -p "$dir_local_bin"
mkdir -p "$dir_local_apps"
mkdir -p "$dir_local_icons"
mkdir -p "$dir_user_wallpaper"
mkdir -p "$dir_wal"
mkdir -p "$dir_kvantum_pywal"
mkdir -p "$dir_qt6ct_colors"

# -------------------------------------------------------------
# Install Dependencies
# -------------------------------------------------------------
log_step "Installing core packages via Pacman..."
sudo pacman -S --needed --noconfirm \
  yay \
  ttf-jetbrains-mono-nerd \
  qt5ct qt6ct rofi

log_step "Installing AUR packages via Yay..."
yay -S --needed --noconfirm \
  awww pywal-16-git wpgtk nwg-look papirus-icon-theme kvantum

# -------------------------------------------------------------
# Ensure ~/.local/bin is in PATH for shell configuration files
# -------------------------------------------------------------
log_step "Checking PATH configuration for shells..."

ensure_path_in_file() {
  local target_file="$1"
  local config_line="$2"

  if [ -f "$target_file" ]; then
    if ! grep -q "\.local/bin" "$target_file"; then
      echo -e "\n# Add ~/.local/bin to PATH\n$config_line" >>"$target_file"
      log_success "Added ~/.local/bin to PATH in $target_file"
    else
      log_info "~/.local/bin is already in PATH in $target_file"
    fi
  fi
}

# Bash & Zsh (POSIX)
ensure_path_in_file "$HOME/.zshrc" 'export PATH="$HOME/.local/bin:$PATH"'
ensure_path_in_file "$HOME/.bashrc" 'export PATH="$HOME/.local/bin:$PATH"'

# Fish (Native command)
ensure_path_in_file "$dir_dot_conf/fish/config.fish" 'fish_add_path $HOME/.local/bin'

# Export for current session execution
export PATH="$dir_local_bin:$PATH"

# -------------------------------------------------------------
# Template Kvantum SVG & Pywal templates
# -------------------------------------------------------------
log_step "Installing templates for Qt, GTK, Pywal, and Hyprland..."
cp -rT ./scripts/template/wal "$dir_wal"

# -------------------------------------------------------------
# Symlink qt6ct/Kvantum colors → cache wal
# -------------------------------------------------------------
log_step "Linking qt6ct and Kvantum color schemes..."
ln -sf "$HOME/.cache/wal/colors-qt6ct.conf" "$dir_qt6ct_colors/pywal.conf"
ln -sf "$HOME/.cache/wal/pywal.svg" "$dir_kvantum_pywal/pywal.svg"
ln -sf "$HOME/.cache/wal/pywal.kvconfig" "$dir_kvantum_pywal/pywal.kvconfig"

# -------------------------------------------------------------
# Config qt6ct
# -------------------------------------------------------------
log_step "Configuring qt6ct..."
if [ -f "$qt6ct_conf" ]; then
  sed -i 's|color_scheme_path=.*|color_scheme_path='"$HOME"'/.config/qt6ct/colors/pywal.conf|' "$qt6ct_conf"
  sed -i 's/custom_palette=false/custom_palette=true/' "$qt6ct_conf"
  log_success "Updated existing $qt6ct_conf"
else
  mkdir -p "$(dirname "$qt6ct_conf")"
  cp ./scripts/template/qt/qt.conf "$qt6ct_conf"
  log_success "Created new $qt6ct_conf"
fi

# -------------------------------------------------------------
# Install "pywal-theme-switcher" executable
# -------------------------------------------------------------
log_step "Installing pywal-theme-switcher script to ~/.local/bin..."
cp -r "./scripts/template/pywal-theme-switcher" "$dir_local_bin"
chmod +x "$dir_local_bin/pywal-theme-switcher/pywal-theme-switcher.sh"

# -------------------------------------------------------------
# Install "pywal-theme-switcher.desktop"
# -------------------------------------------------------------
log_step "Installing icon and .desktop entry..."
cp "./assets/pywal-theme-switcher.svg" "$dir_local_icons/pywal-theme-switcher.svg"
log_info "Copied custom SVG icon to $dir_local_icons/pywal-theme-switcher.svg"

cat <<EOF >"$dir_local_apps/pywal-theme-switcher.desktop"
[Desktop Entry]
Name=Pywal Theme Switcher
Comment=Dynamic Pywal Theme Switcher for Hyprland, GTK, Qt & Quickshell
Exec=$dir_local_bin/pywal-theme-switcher
Icon=pywal-theme-switcher
Terminal=false
Type=Application
Categories=Settings;DesktopSettings;
EOF
log_success "Created $dir_local_apps/pywal-theme-switcher.desktop"

# -------------------------------------------------------------
# Kitty Theme
# -------------------------------------------------------------
log_step "Configuring Kitty terminal colors..."
if ask_yes_no "Do you want to configure colors in Kitty?"; then
  mkdir -p "$(dirname "$kitty_conf")"
  touch "$kitty_conf"
  if ! grep -q "colors-kitty.conf" "$kitty_conf"; then
    echo -e "\n# Include colors generated by Pywal\ninclude ~/.cache/wal/colors-kitty.conf" >>"$kitty_conf"
    log_success "Kitty configured successfully."
  else
    log_info "Kitty is already configured."
  fi
else
  log_info "Skipping Kitty configuration."
fi

# -------------------------------------------------------------
# Hyprland window Theme
# -------------------------------------------------------------
if command -v hyprctl >/dev/null 2>&1 || [ -d "$dir_hypr" ]; then
  mkdir -p "$dir_hypr_colors"

  # -------------------------------------------------------------
  # Env Variables Qt in Hyprland (Lua format)
  # -------------------------------------------------------------
  log_step "Checking Qt environment variables in Hyprland..."
  if [ -f "$dir_hypr_conf" ]; then
    if ! grep -q "QT_QPA_PLATFORMTHEME" "$dir_hypr_conf"; then
      echo -e "\n-- Qt theming" >>"$dir_hypr_conf"
      echo 'hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")' >>"$dir_hypr_conf"
      log_success "Added Qt environment variable to hyprland.lua"
    else
      log_info "Qt environment variable already present in hyprland.lua"
    fi
  else
    log_warn "hyprland.lua not found. Manually add: hl.env(\"QT_QPA_PLATFORMTHEME\", \"qt6ct\")"
  fi

  log_step "Configuring Hyprland window colors..."
  if ask_yes_no "Do you want to copy Hyprland color configuration?"; then
    cp ./scripts/template/hypr/colors.lua "$dir_hypr_colors/colors.lua"
    log_success "Colors file copied to $dir_hypr_colors/colors.lua"
  else
    log_info "Skipping Hyprland color configuration."
  fi

  # -------------------------------------------------------------
  # Set up shortcut to change the theme in Hyprland
  # -------------------------------------------------------------
  log_step "Setting up Hyprland keybinding..."
  if ask_yes_no "Do you want to configure the theme switcher keybind?"; then
    TARGET_FILE=$(grep -rl "hl.bind" "$dir_hypr" | head -n 1)

    if [ -n "$TARGET_FILE" ]; then
      if ! grep -q "~/.local/bin/pywal-theme-switcher" "$TARGET_FILE"; then
        # Inject binding using executable path
        sed -i '0,/hl.bind/{s|hl.bind|hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.local/bin/pywal-theme-switcher"))\nhl.bind|}' "$TARGET_FILE"
        log_success "Added keybind to: ${BLUE}${TARGET_FILE}${NC}"
      else
        log_info "Keybind already present in ${BLUE}${TARGET_FILE}${NC}, skipping."
      fi
    else
      log_warn "No active file with 'hl.bind' found in $dir_hypr."
      log_warn "Manually add: hl.bind(mainMod .. \" + SHIFT + T\", hl.dsp.exec_cmd(\"~/.local/bin/pywal-theme-switcher\"))"
    fi
  else
    log_info "Skipping Hyprland keybind configuration."
  fi
fi

echo ""
echo "────────────────────────────────────────────────────────────────────────"
echo "🎉 Pywal Theme Switcher setup complete!"
echo ""
echo "⭐ If you like it, drop a star! It helps a lot 🫰💖"
echo "https://github.com/ByTrist4n/pywal-theme-switcher"
echo ""
echo "Next steps:"
echo " 1. Copy your wallpapers to $dir_user_wallpaper"
echo " 2. Reload and Run \"pywal-theme-switcher\" from your terminal to test"
echo ""
echo "────────────────────────────────────────────────────────────────────────"

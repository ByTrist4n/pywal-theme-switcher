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
dir_rofi="$dir_dot_conf/rofi"
dir_user_wallpaper="$HOME/Pictures/Wallpapers"
dir_wal="$dir_dot_conf/wal"
dir_kvantum_pywal="$dir_dot_conf/Kvantum/pywal"
dir_qt="$dir_dot_conf/qt6ct"
dir_qt6ct_colors="$dir_qt/colors"
qt6ct_conf="$dir_qt/qt6ct.conf"
kitty_conf="$dir_dot_conf/kitty/kitty.conf"
dir_switcher_config="$dir_dot_conf/pywal-theme-switcher"
switcher_config_toml="$dir_switcher_config/config.toml"
dir_kde_colors="$HOME/.local/share/color-schemes"

# Defaults
preferred_launcher=""
export auto_yes=false

# -------------------------------------------------------------
# Command Line Argument Parsing Loop
# -------------------------------------------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
  --walker)
    preferred_launcher="walker"
    shift
    ;;
  --rofi)
    preferred_launcher="rofi"
    shift
    ;;
  -y | --yes)
    export auto_yes=true
    shift
    ;;
  --help | -h)
    echo "Usage: $0 [--walker|--rofi] [-y|--yes]"
    exit 0
    ;;
  *)
    log_error "Unknown option: $1"
    echo "Usage: $0 [--walker|--rofi] [-y|--yes]"
    exit 1
    ;;
  esac
done

log_step "Creating directory structure..."
mkdir -p \
  "$dir_local_bin" \
  "$dir_local_apps" \
  "$dir_local_icons" \
  "$dir_user_wallpaper" \
  "$dir_wal" \
  "$dir_kvantum_pywal" \
  "$dir_qt6ct_colors" \
  "$dir_rofi" \
  "$dir_switcher_config"

# -------------------------------------------------------------
# Configuration File Creation (TOML)
# -------------------------------------------------------------
if [[ -z "$preferred_launcher" ]]; then
  if [[ "$auto_yes" == "true" ]]; then
    preferred_launcher="rofi"
  else
    echo ""
    log_info "Selecting preferred application launcher..."
    echo "Which launcher do you want to use for wallpaper selection?"
    echo "  1) rofi (Default)"
    echo "  2) walker"

    while true; do
      read -rp "Select option [1-2]: " launcher_choice

      case "$launcher_choice" in
      1)
        preferred_launcher="rofi"
        break
        ;;
      2)
        preferred_launcher="walker"
        break
        ;;
      *)
        log_warn "Invalid selection. Please enter 1 or 2."
        ;;
      esac
    done
  fi
fi

log_info "Selected launcher: $preferred_launcher"

cat <<EOF >"$switcher_config_toml"
# Pywal Theme Switcher Configuration

[general]
# Preferred application launcher for wallpaper selection
# Options: "rofi", "walker"
launcher = "$preferred_launcher"

[notifications]
enable = true
EOF

log_success "Created configuration file at $switcher_config_toml"

# -------------------------------------------------------------
# Install Dependencies
# -------------------------------------------------------------
# Helper function to ensure yay is installed
ensure_aur_helper() {
  if ! command -v yay &>/dev/null; then
    log_info "AUR helper (yay) not found. Bootstrapping yay..."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    if git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay" &&
      (cd "$tmp_dir/yay" && makepkg -si --noconfirm); then
      rm -rf "$tmp_dir"
      log_success "yay successfully bootstrapped!"
    else
      rm -rf "$tmp_dir"
      log_error "Failed to bootstrap yay."
      exit 1
    fi
  fi
}

log_step "Installing core packages via Pacman..."

PACMAN_PKGS=(
  ttf-jetbrains-mono-nerd
  qt5ct
  qt6ct
  libnotify
)

if [[ "$preferred_launcher" == "rofi" ]]; then
  PACMAN_PKGS+=(rofi)
fi

sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# Ensure yay is ready before calling it
ensure_aur_helper

log_step "Installing AUR packages via Yay..."

AUR_PKGS=(
  awww
  python-pywal16-git
  wpgtk
  nwg-look
  papirus-icon-theme
  kvantum
)

# If Walker is chosen, include Walker AND Elephant ecosystem dependencies
if [[ "$preferred_launcher" == "walker" ]]; then
  AUR_PKGS+=(
    walker
    elephant
    elephant-files
  )
fi

yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# -------------------------------------------------------------
# Ensure ~/.local/bin is in PATH
# -------------------------------------------------------------
log_step "Checking PATH configuration for shells..."

ensure_path_in_file() {
  local target_file="$1"
  local config_line="$2"

  if [[ ! -f "$target_file" ]]; then
    return
  fi

  if grep -Fq ".local/bin" "$target_file"; then
    log_info "~/.local/bin is already in PATH in $target_file"
    return
  fi

  echo -e "\n# Add ~/.local/bin to PATH\n$config_line" >>"$target_file"
  log_success "Added ~/.local/bin to PATH in $target_file"
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
# Install Full Rofi Configuration Directory
# -------------------------------------------------------------
log_step "Installing Rofi configuration directory..."

if [[ -d "./scripts/template/rofi" ]]; then
  cp -rT "./scripts/template/rofi" "$dir_rofi"
  log_success "Copied full Rofi configuration to $dir_rofi"
fi

# -------------------------------------------------------------
# Symlink qt6ct/Kvantum/KDE colors → cache wal
# -------------------------------------------------------------
log_step "Linking qt6ct, Kvantum and KDE color schemes..."

mkdir -p "$dir_kde_colors"

ln -sf "$HOME/.cache/wal/colors-qt6ct.conf" "$dir_qt6ct_colors/pywal.conf"
ln -sf "$HOME/.cache/wal/kdeglobals" "$dir_dot_conf/kdeglobals"
ln -sf "$HOME/.cache/wal/pywal.kvconfig" "$dir_kvantum_pywal/pywal.kvconfig"
ln -sf "$HOME/.cache/wal/pywal.svg" "$dir_kvantum_pywal/pywal.svg"
ln -sf "$HOME/.cache/wal/Pywal.colors" "$dir_kde_colors/Pywal.colors"

# Activate pywal theme inside Kvantum Manager
if command -v kvantummanager &>/dev/null; then
  kvantummanager --set pywal &>/dev/null || true
  log_success "Activated 'pywal' theme in Kvantum Manager"
fi
# -------------------------------------------------------------
# Config qt6ct
# -------------------------------------------------------------
log_step "Configuring qt6ct..."

if [[ -f "$qt6ct_conf" ]]; then
  sed -i \
    -e "s|color_scheme_path=.*|color_scheme_path=$HOME/.config/qt6ct/colors/pywal.conf|" \
    -e "s|^custom_palette=.*|custom_palette=true|" \
    -e "s|^style=.*|style=kvantum|" \
    "$qt6ct_conf"
    
  log_success "Updated existing $qt6ct_conf"
else
  mkdir -p "$(dirname "$qt6ct_conf")"
  if [[ -f "./scripts/template/qt/qt6ct.conf" ]]; then
    sed "s|__USER__|$USER|g" "./scripts/template/qt/qt6ct.conf" > "$qt6ct_conf"
    log_success "Created new $qt6ct_conf from template"
  else
    log_error "Template ./scripts/template/qt/qt6ct.conf not found."
  fi
fi

# -------------------------------------------------------------
# Install "pywal-theme-switcher" executable
# -------------------------------------------------------------
log_step "Installing pywal-theme-switcher script to ~/.local/bin..."

cp "./scripts/pywal-theme-switcher" "$dir_local_bin"
chmod +x "$dir_local_bin/pywal-theme-switcher"

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
# Universal GTK configuration
# -------------------------------------------------------------
log_step "Setting up GTK theme..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' 2>/dev/null || true

mkdir -p "$dir_dot_conf/gtk-3.0" "$dir_dot_conf/gtk-4.0"

# Create settings.ini only if it does not exist
if [[ ! -f "$dir_dot_conf/gtk-3.0/settings.ini" ]]; then
  printf '[Settings]\ngtk-theme-name = Adwaita-dark\ngtk-application-prefer-dark-theme = 1\n' \
    >"$dir_dot_conf/gtk-3.0/settings.ini"
fi

ln -sf "$HOME/.cache/wal/gtk.css" "$dir_dot_conf/gtk-3.0/gtk.css"
ln -sf "$HOME/.cache/wal/gtk.css" "$dir_dot_conf/gtk-4.0/gtk.css"

log_success "Configured GTK 3/4"

# -------------------------------------------------------------
# Kitty Theme
# -------------------------------------------------------------
log_step "Configuring Kitty terminal colors..."

if ask_yes_no "Do you want to configure colors in Kitty?"; then
  mkdir -p "$(dirname "$kitty_conf")"
  touch "$kitty_conf"

  if ! grep -Fq "colors-kitty.conf" "$kitty_conf"; then
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
if command -v hyprctl >/dev/null 2>&1 || [[ -d "$dir_hypr" ]]; then
  mkdir -p "$dir_hypr_colors"

  # -------------------------------------------------------------
  # Env Variables Qt in Hyprland (Lua format)
  # -------------------------------------------------------------
  log_info "Checking Qt environment variables in Hyprland..."

  if [[ -f "$dir_hypr_conf" ]]; then
    if ! grep -Fq "QT_QPA_PLATFORMTHEME" "$dir_hypr_conf"; then
      echo -e "\n-- Qt theming" >>"$dir_hypr_conf"
      echo 'hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")' >>"$dir_hypr_conf"
      log_success "Added Qt environment variable to hyprland.lua"
    else
      log_info "Qt environment variable already present in hyprland.lua"
    fi
  else
    log_warn "hyprland.lua not found. Manually add: hl.env(\"QT_QPA_PLATFORMTHEME\", \"qt6ct\")"
  fi

  log_info "Configuring Hyprland window colors..."

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

    if [[ -n "$TARGET_FILE" ]]; then
      if ! grep -Fq "pywal-theme-switcher" "$TARGET_FILE"; then
        # Inject binding using executable path
        sed -i '0,/hl.bind/{s|hl.bind|hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("pywal-theme-switcher"))\nhl.bind|}' "$TARGET_FILE"
        log_success "Added keybind to: ${BLUE}${TARGET_FILE}${NC}"
      else
        log_info "Keybind already present in ${BLUE}${TARGET_FILE}${NC}, skipping."
      fi
    else
      log_warn "No active file with 'hl.bind' found in $dir_hypr."
      log_warn "Manually add: hl.bind(mainMod .. \" + SHIFT + T\", hl.dsp.exec_cmd(\"pywal-theme-switcher\"))"
    fi
  else
    log_info "Skipping Hyprland keybind configuration."
  fi
fi

# -------------------------------------------------------------
# Set default Wallpaper if Wallpaper folder is empty
# -------------------------------------------------------------
log_step "Checking wallpaper directory..."

if [[ -z "$(ls -A "$dir_user_wallpaper" 2>/dev/null)" ]]; then
  log_info "Wallpaper folder is empty. Setting up default wallpaper..."

  # Find the default wallpaper asset in assets/
  default_wp=$(find ./assets -maxdepth 1 -type f -name "wallpaper-default.*" | head -n 1)

  if [[ -n "$default_wp" ]]; then
    cp "$default_wp" "$dir_user_wallpaper/"
    log_success "Copied default wallpaper to $dir_user_wallpaper"

    # Set initial colors silently using the installed script
    if [[ -x "$dir_local_bin/pywal-theme-switcher" ]]; then
      log_info "Applying initial color scheme in background..."
      "$dir_local_bin/pywal-theme-switcher" --default >/dev/null 2>&1 || true
      log_success "Initial color scheme generated successfully!"
    fi
  else
    log_warn "No default wallpaper found in ./assets'"
  fi
else
  log_info "Wallpapers already present in $dir_user_wallpaper"
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
echo " 2. Reload your shell or open a new terminal"
echo " 3. Run \"pywal-theme-switcher\" to test"
echo ""
echo "────────────────────────────────────────────────────────────────────────"
<div align="center">

<img src="./assets/pywal-theme-switcher.svg" alt="Icon Pywal Theme Switcher" width="128" />

<br>

<br>

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Sixtyfour&size=24&pause=1000&color=1793d1&width=480&lines=Pywal+Theme+Switcher;ByTrist4n)](https://git.io/typing-svg)

[![GitHub Release](https://img.shields.io/github/v/release/ByTrist4n/pywal-theme-switcher?style=for-the-badge&color=1793d1&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![Last Commit](https://img.shields.io/github/last-commit/ByTrist4n/pywal-theme-switcher?style=for-the-badge&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![GitHub Stars](https://img.shields.io/github/stars/ByTrist4n/pywal-theme-switcher?style=for-the-badge&logo=github&color=daaa3f&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![Repo Size](https://img.shields.io/github/repo-size/ByTrist4n/pywal-theme-switcher?style=for-the-badge&logo=codesandbox&color=DDB&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![Hyprland](https://img.shields.io/badge/Hyprland-v0.55%2B-1793d1?logo=hyprland&style=for-the-badge&logoColor=1793d1&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)

</div>

<br>

# What is it?

**Pywal Theme Switcher** is a lightweight script that extracts colors from your wallpaper and dynamically applies them across your desktop environment.

It can synchronize themes for:

- 🌈 Pywal / WPGTK
- 🪟 Hyprland
- 🎨 GTK 3 / GTK 4
- 🖥️ Qt 5 / Qt 6
- 🌌 Kvantum
- 🐧 KDE color schemes
- 🛸 Quickshell
- 🐱 Kitty

Hyprland and Quickshell are optional, so Pywal Theme Switcher can also be used with other Wayland desktop environments or window managers.

> ⭐ If you like this project, consider leaving a **star on GitHub**! It helps a lot! 🫰💖

> [!TIP]
> 🚀 **Looking for a Complete Out-of-the-Box Experience?**
>
> **`pywal-theme-switcher` is natively integrated and pre-configured** inside my full Arch Linux / CachyOS Rice.
>
> Get seamless color switching, automated GTK/Qt/Hyprland/Quickshell theming, and an optimized desktop setup with a single command:
>
> 🗂️ **Installer Repository:** [ByTrist4n / hyprland-setup](https://github.com/ByTrist4n/hyprland-setup)

<br>

# Preview

![Screenshot Switch theme](./assets/screenshots/preview-pywal-theme-switcher.jpg)

<br>

# Getting Started

## Prerequisites

**Hyprland is optional.**

Pywal Theme Switcher can be used without Hyprland.

If you are using Hyprland, **v0.55+ with Lua support** is required.

You can check your version with:

```bash
hyprland --version
```

The installer is designed for **Arch Linux and Arch-based distributions** using `pacman` and the AUR.

<br>

## Installation

Clone the repository and run the installation script from the project root:

```bash
git clone https://github.com/ByTrist4n/pywal-theme-switcher.git

cd pywal-theme-switcher

./install.sh
```

During installation, you can choose between **Rofi** and **Walker** as your wallpaper selector.

### Walker

```bash
./install.sh --walker
```

### Rofi

```bash
./install.sh --rofi
```

### Non-Interactive Installation

Use `-y` or `--yes` to automatically accept configuration prompts:

```bash
./install.sh --walker -y
```

or:

```bash
./install.sh --rofi -y
```

If no launcher is specified, the installer asks which launcher you want to use.

<br>

# 🎨 How It Works

When you launch `pywal-theme-switcher`, the script:

1. 🖼️ Lets you select a wallpaper using **Walker or Rofi**.
2. 🌈 Generates a color palette using **Pywal 16 / WPGTK**.
3. 🖥️ Applies the generated colors to the configured applications.
4. 🪟 Updates **Hyprland** colors when Hyprland is available.
5. 🎨 Updates **Qt / Kvantum** themes.
6. 🐧 Updates **GTK 3 / GTK 4** theming.
7. 🐧 Updates **KDE color schemes**.
8. 🐱 Updates **Kitty** colors when configured.
9. 🛸 Refreshes **Quickshell** when configured.
10. 🪝 Executes executable post-hooks.
11. 🔄 Reloads the relevant desktop components.
12. 🔔 Sends a desktop notification when notifications are enabled.

<br>

# 🚀 Usage

Launch the theme switcher:

```bash
pywal-theme-switcher
```

The switcher will open your configured wallpaper selector.

You can also use the executable directly:

```bash
~/.local/bin/pywal-theme-switcher
```

<br>

# 🛠️ Tech Stack

[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)](https://archlinux.org)
[![CachyOS](https://img.shields.io/badge/CachyOS-00A88F?style=for-the-badge&logo=cachyos&logoColor=white)](https://cachyos.org)
[![Hyprland](https://img.shields.io/badge/Hyprland-1793D1?logo=hyprland&logoColor=fff&style=for-the-badge)](https://hyprland.org)

## 📦 Core Dependencies

The installer installs the following packages through **Pacman**:

| Package                                | Description                                      |
| :------------------------------------- | :----------------------------------------------- |
| 🚀 [yay](https://github.com/Jguer/yay) | AUR helper and pacman wrapper                    |
| 🖼️ imagemagick                         | Image processing utilities                       |
| 🖼️ libavif                             | AVIF image format support                        |
| 🖼️ libheif                             | HEIF / HEIC image format support                 |
| 🔔 libnotify                           | Desktop notification support                     |
| 🎨 qt5ct                               | Qt5 configuration utility                        |
| 🎨 qt6ct                               | Qt6 configuration utility                        |
| 🔍 rofi                                | Application launcher and wallpaper selector      |
| 🔤 ttf-jetbrains-mono-nerd             | Developer font with specialized glyphs and icons |

> **Note**: rofi is only installed when Rofi is selected.

## 🛸 AUR Dependencies

The installer uses **yay** to install the following AUR packages:

| Package               | Description                                  |
| :-------------------- | :------------------------------------------- |
| 🖼️ awww               | Dynamic Wayland wallpaper daemon             |
| 🐘 elephant           | Walker backend / provider framework          |
| 📁 elephant-files     | File provider for Walker                     |
| 🌌 kvantum            | SVG-based theme engine for Qt                |
| 🎨 papirus-icon-theme | Material Design icon theme for Linux         |
| 🌈 python-pywal16-git | Pywal 16 color palette generator             |
| 🕶️ nwg-look           | GTK3/4 configuration utility for Wayland     |
| 🚶 walker             | Application launcher and wallpaper selector  |
| 🛠️ wpgtk              | Universal theme template manager using Pywal |

> **Note:**: `walker`, `elephant` and `elephant-files` are installed only when Walker is selected.

<br>

# 🪝 Post-Hooks System

`pywal-theme-switcher` supports custom executable scripts that run automatically after every theme change.

This makes it possible to synchronize additional applications or services with your Pywal colors.

## Directory

Hooks are stored in:

```text
~/.local/share/pywal-theme-switcher/post-hooks.d/
```

## Creating a Hook

Create a script:

```bash
touch ~/.local/share/pywal-theme-switcher/post-hooks.d/01-custom.sh
```

Add your commands with a proper shebang:

```bash
#!/usr/bin/env bash

# Your commands here
```

Make it executable:

```bash
chmod +x ~/.local/share/pywal-theme-switcher/post-hooks.d/01-custom.sh
```

Executable hooks are automatically executed after a theme change.

<br>

# 🔔 Notifications

Desktop notifications can be enabled or disabled through:

```text
~/.config/pywal-theme-switcher/config.toml
```

Enable notifications:

```toml
[notifications]
enable = true
```

Disable notifications:

```toml
[notifications]
enable = false
```

<br>

# 🐱 Kitty

During installation, you can optionally configure Kitty to load the colors generated by Pywal.

The generated colors are loaded from:

```text
~/.cache/wal/colors-kitty.conf
```

The installer adds the following include to your Kitty configuration:

```conf
include ~/.cache/wal/colors-kitty.conf
```

<br>

## ⌨️ Hyprland Keybind

The installer can optionally configure:

```text
SUPER + SHIFT + T
```

This launches:

```bash
pywal-theme-switcher
```

You can also launch the switcher manually:

```bash
pywal-theme-switcher
```

or:

```bash
~/.local/bin/pywal-theme-switcher
```

<br>

# ⚙️ Configuration

The main configuration file is:

```text
~/.config/pywal-theme-switcher/config.toml
```

The launcher is configured automatically during installation.

Example:

```toml
[general]
launcher = "walker"

[notifications]
enable = true
```

Supported launchers:

```text
walker
rofi
```

<br>

# 📁 Wallpapers

Wallpapers are stored in:

```text
~/Pictures/Wallpapers
```

Supported image formats include:

```text
.jpg
.jpeg
.png
.webp
```

<br>

<div align="center">

⭐ **If you like Pywal Theme Switcher, consider giving it a star!** ⭐

🫰💖

</div>

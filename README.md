<div align="center">

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Sixtyfour&size=24&pause=1000&color=1793d1&width=480&lines=Pywal+Theme+Switcher;ByTrist4n)](https://git.io/typing-svg)

[![GitHub stars](https://img.shields.io/github/stars/ByTrist4n/pywal-theme-switcher?style=for-the-badge&logo=github&color=daaa3f&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![Last Commit](https://img.shields.io/github/last-commit/ByTrist4n/pywal-theme-switcher?style=for-the-badge&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![Repo Size](https://img.shields.io/github/repo-size/ByTrist4n/pywal-theme-switcher?style=for-the-badge&logo=codesandbox&color=DDB&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)
[![Hyprland](https://img.shields.io/badge/Hyprland-v0.55%2B-1793d1?logo=hyprland&style=for-the-badge&logoColor=1793d1&labelColor=252733)](https://github.com/ByTrist4n/pywal-theme-switcher)

</div>

<br>

# What is it?

**Pywal Theme Switcher** is a small script that extracts the colors from the current wallpaper and applies them to all applications in the environment (Qt, GTK, Quickshell, Hyprland).

> If you like this setup, please consider leaving **a star ⭐ on GitHub**! It helps a lot! 🫰💖

> 🚀 Need Automated Installation? To install and orchestrate this environment automatically on CachyOS / Arch Linux, check out my installer repository: [ByTrist4n / hyprland-setup](https://github.com/ByTrist4n/hyprland-setup)

<br>

# Preview

![Screenshot Switch theme](screenshots/screenshot_theme_switch.jpg)

<br>

# Getting Started

### Prerequisites

Hyprland v0.55 minimum with lua, run :

```bash
hyprland --version
```

### Installation

To install, clone the repository and execute the installation script from the root directory:
Bash

```bash
git clone https://github.com/ByTrist4n/pywal-theme-switcher
cd pywal-theme-switcher
sh install.sh
```

<br>

# 🛠️ Tech Stack

[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)](https://archlinux.org)
[![Hyprland](https://img.shields.io/badge/Hyprland-1793D1?logo=hyprland&logoColor=fff&style=for-the-badge)](https://hyprland.org)

### 📦 Core Dependencies (Pacman)

| Package                                                                                                | Description                                      |
| :----------------------------------------------------------------------------------------------------- | :----------------------------------------------- |
| 🚀 [yay](https://github.com/Jguer/yay)                                                                 | AUR helper and pacman wrapper                    |
| 🔤 [ttf-jetbrains-mono-nerd](https://github.com/ryanoasis/nerd-fonts)                                  | Developer font with specialized glyphs and icons |
| 🎨 [qt5ct](https://sourceforge.net/projects/qt5ct/) / [qt6ct](https://sourceforge.net/projects/qt5ct/) | Qt5 and Qt6 configuration utilities              |
| 🔍 [rofi](https://github.com/davatorium/rofi)                                                          | Window switcher and application launcher         |

### 🛸 AUR Dependencies (Yay)

| Package                                                                               | Description                                         |
| :------------------------------------------------------------------------------------ | :-------------------------------------------------- |
| 🖼️ [awww](https://codeberg.org/LGFae/awww)                                            | Dynamic wallpaper generator and wrapper             |
| 🌈 [python-pywal16](https://github.com/eylles/pywal16)                                | Color palette generation from images (Pywal fork)   |
| 🛠️ [wpgtk](https://github.com/deviantfero/wpgtk)                                      | Universal theme template manager using Pywal        |
| 🕶️ [nwg-look](https://github.com/nwg-piotr/nwg-look)                                  | GTK3/4 configuration customization tool for Wayland |
| 🎨 [papirus-icon-theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) | Material design icon theme for Linux                |
| 🌌 [kvantum](https://github.com/tsujan/Kvantum)                                       | SVG-based theme engine for Qt5/Qt6                  |

<br>

# 🪝 Post-Hooks System (`post-hooks.d`)

`pywal-theme-switcher` supports custom executable scripts triggered automatically after every theme change. This allows you to sync external services (SDDM, Discord, terminal emulators, etc.) with your new Pywal color palette.

### Directory Location

Create the hooks directory if it doesn't exist yet:

```bash
mkdir -p ~/.config/pywal-theme-switcher/post-hooks.d
```

### Creating & Activating a New Hook

- Create a script inside `~/.config/pywal-theme-switcher/post-hooks.d/`

  ```bash
  touch ~/.config/pywal-theme-switcher/post-hooks.d/01-sddm.sh
  ```

- Add your shell commands with a proper shebang (`#!/bin/bash`).

- Grant execution permissions:
  ```bash
  chmod +x ~/.config/pywal-theme-switcher/post-hooks.d/01-sddm.sh
  ```

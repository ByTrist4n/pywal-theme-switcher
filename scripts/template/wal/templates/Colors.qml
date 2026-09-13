import QtQuick 2.15

/*
 * Dynamic Pywal color scheme mapping for SDDM / Quickshell
 */
QtObject {
    // Primary background and foreground
    property color background: "#11111b"
    property color foreground: "#cdd6f4"
    // Pywal color palette mapping
    property color color0: "#181825"
    property color color1: "#f38ba8"
    property color color2: "#a6e3a1"
    property color color3: "#f9e2af"
    property color color4: "#89b4fa"
    property color color5: "#cba6f7"
    property color color6: "#7dcfff"
    property color color7: "#a6adc8"
    // Bright variants
    property color color8: "#313244"
    property color color9: "#313244"
    property color color10: "#11111b"
    property color color11: "#f9e2af"
    property color color12: "#89b4fa"
    property color color13: "#cba6f7"
    property color color14: "#7dcfff"
    property color color15: "#cdd6f4"
    // UI functional aliases
    property color accent: color4
    property color active: color2
    property color warning: color3
    property color danger: color1
}

import QtQuick 2.15

/*
 * Dynamic Pywal color scheme mapping for SDDM / Quickshell
 */
QtObject {
    // Primary background and foreground
    property color background: "{background}"
    property color foreground: "{foreground}"
    // Pywal color palette mapping
    property color color0: "{color0}"
    property color color1: "{color1}"
    property color color2: "{color2}"
    property color color3: "{color3}"
    property color color4: "{color4}"
    property color color5: "{color5}"
    property color color6: "{color6}"
    property color color7: "{color7}"
    // Bright variants
    property color color8: "{color8}"
    property color color9: "{color9}"
    property color color10: "{color10}"
    property color color11: "{color11}"
    property color color12: "{color12}"
    property color color13: "{color13}"
    property color color14: "{color14}"
    property color color15: "{color15}"
    // UI functional aliases
    property color accent: color4
    property color active: color2
    property color warning: color3
    property color danger: color1
}

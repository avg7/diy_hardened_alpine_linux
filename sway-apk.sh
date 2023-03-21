#!/bin/sh
/sbin/apk add eudev libinput sway sway-doc xwayland swaylock swayidle ttf-freefont mesa mesa-dri-gallium mesa-egl mesa-gbm mesa-gl mesa-glapi mesa-gles seatd seatd-openrc yambar swaylockd brightnessctl fuzzel alsa-utils alsa-utils-doc alsa-lib alsaconf pulseaudio pulseaudio-alsa alsa-plugins-pulse pavucontrol firefox-esr icu-libs nemo foot wlsunset geany ttf-font-awesome;

# Recommended lightweight Software:
# Sway: (eudev libinput sway sway-doc xwayland swaylock swaylockd swayidle ttf-freefont mesa-dri-intel mesa-dri-gallium brightnessctl seatd seatd-openrc)*
# Audio: (alsa-utils alsa-utils-doc alsa-lib alsaconf pulseaudio pulseaudio-alsa alsa-plugins-pulse pavucontrol)*
# Gamma: wlsunset*
# File Manager: nemo*
# Menu: bemenu  
# Launcher: "wofi" wldash lavalauncher fuzzel* nwg-launchers
# Bar/Panels: (yambar ttf-font-awesome)* waybar
# Terminal Emulator: havoc alacritty sakura foot* kitty
# Log-in managers: tuigreet greetd
# Browser: qutebrowser falkon firefox-esr*
# Automount: udevil udisks2
# Image Viewer: vimiv imv
# Video Player: mpv
# Text Editor: geany*
# Document Viewer: (zathura zathura-pdf-poppler) evince
# Music Player: mpg123
# Email Client: mutt kmail thunderbird
# * already included in the "apk add command" at the top

# Sources: 
# github.com/swaywm/sway/wiki/Useful-add-ons-for-sway
# github.com/natpen/awesome-wayland
# llandy3d.github.io/sway-on-ubuntu/extra

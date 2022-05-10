#!/usr/bin/bash

if [[ "$DOTFILES_PC" == "laptop" ]]; then
  rofi -dpi 120 -modi 'drun,filebrowser,run' -show drun
fi

if [[ "$DOTFILES_PC" == "laptop-desktop" ]]; then
  rofi -modi 'drun,filebrowser,run' -show drun
fi

if [[ "$DOTFILES_PC" == "desktop" ]]; then
  rofi -modi 'drun,filebrowser,run' -show drun
fi

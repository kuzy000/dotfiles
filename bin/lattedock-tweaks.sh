#!/usr/bin/bash

if [[ "$DOTFILES_PC" == "laptop" ]]; then
  bspc subscribe report | "$HOME/bin/lattedock-tweaks.py" eDP-1
fi

if [[ "$DOTFILES_PC" == "desktop" ]]; then
  bspc subscribe report | "$HOME/bin/lattedock-tweaks.py" HDMI-0 DVI-D-0
fi

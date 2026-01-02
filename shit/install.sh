#!/usr/bin/env bash

mkdir -p "$HOME/.config/xfce4/"
cp "$HOME/nixos-private-dots/shit/helpers.rc" "$HOME/.config/xfce4/helpers.rc"
cp "$HOME/nixos-private-dots/shit/mimeapps.list" "$HOME/.config/mimeapps.list"

cp -r "$HOME/nixos-private-dots/shit/Kvantum" "$HOME/.config/Kvantum"
cp -r "$HOME/nixos-private-dots/shit/qt5ct" "$HOME/.config/qt5ct"
cp -r "$HOME/nixos-private-dots/shit/qt6ct" "$HOME/.config/qt6ct"

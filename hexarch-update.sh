#!/usr/bin/env bash

# HexArch OS Custom Update Script
# Safely updates system, AUR, Flatpak, and notifies user of important changes.

set -e

# Update system packages
echo "[HexArch OS] Updating system packages..."
sudo pacman -Syu --noconfirm

# Update AUR packages (if yay or paru is installed)
if command -v yay &>/dev/null; then
    echo "[HexArch OS] Updating AUR packages with yay..."
    yay -Syu --noconfirm
elif command -v paru &>/dev/null; then
    echo "[HexArch OS] Updating AUR packages with paru..."
    paru -Syu --noconfirm
else
    echo "[HexArch OS] No AUR helper found (yay/paru). Skipping AUR update."
fi

# Update Flatpak apps (if installed)
if command -v flatpak &>/dev/null; then
    echo "[HexArch OS] Updating Flatpak apps..."
    flatpak update -y
fi

# Clean up orphaned packages
echo "[HexArch OS] Removing orphaned packages..."
sudo pacman -Rns --noconfirm $(pacman -Qtdq) 2>/dev/null || true

# Notify user
if command -v notify-send &>/dev/null; then
    notify-send "HexArch OS Update" "System and apps updated successfully!"
fi

echo "[HexArch OS] Update complete!"

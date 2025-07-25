#!/usr/bin/env bash

set -e

# Set your branding directory (edit as needed)
BRANDING_DIR="$(dirname "$0")/branding"
PLYMOUTH_THEME="$BRANDING_DIR/boot/plymouth"
GRUB_THEME="$BRANDING_DIR/boot/grub"
OS_LOGO_LOGIN="$BRANDING_DIR/os-logo/login"
OS_LOGO_MENU="$BRANDING_DIR/os-logo/menu"
NEOFETCH_LOGO="$BRANDING_DIR/neofetch/hexarch_logo.txt"
CUSTOM_CURSOR="$BRANDING_DIR/cursor"

# Ask user for pentesting tools
choose_pentest_tools() {
    echo "Select pentesting tools to install:"
    select choice in "None" "Minimal" "Full (BlackArch)"; do
        case $REPLY in
            1) PENTEST="none"; break ;;
            2) PENTEST="minimal"; break ;;
            3) PENTEST="full"; break ;;
            *) echo "Invalid option";;
        esac
    done
}

# Ask user for Desktop Environment/WM
choose_de() {
    echo "Select Desktop Environment/Window Manager:"
    select choice in "Hyprland" "GNOME" "KDE Plasma"; do
        case $REPLY in
            1) DE="hyprland"; DM="greetd"; break ;;
            2) DE="gnome"; DM="gdm"; break ;;
            3) DE="plasma"; DM="sddm"; break ;;
            *) echo "Invalid option";;
        esac
    done
}

# Install pentesting tools
install_pentest_tools() {
    case $PENTEST in
        none)
            echo "Skipping pentesting tools."
            ;;
        minimal)
            echo "Installing minimal pentesting tools..."
            pacman -S --noconfirm nmap wireshark-qt metasploit john aircrack-ng
            ;;
        full)
            echo "Adding BlackArch repository and installing full tools..."
            curl -O https://blackarch.org/strap.sh
            chmod +x strap.sh
            ./strap.sh
            pacman -Syyu --noconfirm blackarch
            ;;
    esac
}

# Install gaming packages
install_gaming_packages() {
    echo "Installing gaming packages..."
    pacman -S --noconfirm gamemode mangohud wine-staging lutris steam \
        lib32-vulkan-icd-loader lib32-vulkan-driver
}

# Install performance and optimization packages
install_performance_tools() {
    echo "Installing performance and optimization tools..."
    pacman -S --noconfirm preload zram earlyoom systemd-analyze anacron cronie linux-zen auto-cpufreq zram-generator thermald ananicy tuned
    # Enable preload daemon
    systemctl enable --now preload
    # Enable zram-generator (systemd-native zram)
    systemctl enable --now systemd-zram-setup@zram0.service || true
    # Enable earlyoom (or oomd if preferred)
    systemctl enable --now earlyoom || true
    # Enable anacron/cron
    systemctl enable --now anacron || systemctl enable --now cronie || true
    # Enable auto-cpufreq
    systemctl enable --now auto-cpufreq || true
    # Enable thermald (for Intel CPUs)
    systemctl enable --now thermald || true
    # Enable ananicy
    systemctl enable --now ananicy || true
    # Enable tuned
    systemctl enable --now tuned || true
}

# Optionally install Zen kernel
install_zen_kernel() {
    echo "Install Zen kernel for performance? (y/n)"
    read -r answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        pacman -S --noconfirm linux-zen linux-zen-headers
        echo "Zen kernel installed."
    fi
}

# Install Desktop Environment/WM
install_de() {
    case $DE in
        hyprland)
            pacman -S --noconfirm hyprland greetd
            ;;
        gnome)
            pacman -S --noconfirm gnome gdm
            ;;
        plasma)
            pacman -S --noconfirm plasma sddm
            ;;
    esac
}

# Apply branding
apply_branding() {
    echo "Applying HexArch OS branding..."

    # Plymouth
    if [ -d "$PLYMOUTH_THEME" ]; then
        cp -r "$PLYMOUTH_THEME" /usr/share/plymouth/themes/
        THEME_NAME=$(basename "$PLYMOUTH_THEME")
        plymouth-set-default-theme -R "$THEME_NAME"
    fi

    # GRUB
    if [ -d "$GRUB_THEME" ]; then
        cp -r "$GRUB_THEME" /boot/grub/themes/
        THEME_NAME=$(basename "$GRUB_THEME")
        sed -i "s|^#*GRUB_THEME=.*|GRUB_THEME=\"/boot/grub/themes/$THEME_NAME/theme.txt\"|" /etc/default/grub
        grub-mkconfig -o /boot/grub/grub.cfg
    fi

    # OS Logo (login/menu)
    if [ -d "$OS_LOGO_LOGIN" ]; then
        cp "$OS_LOGO_LOGIN"/* /usr/share/pixmaps/
        # Add more logic for your DM/DE as needed
    fi
    if [ -d "$OS_LOGO_MENU" ]; then
        cp "$OS_LOGO_MENU"/* /usr/share/icons/
    fi

    # Neofetch logo
    if [ -f "$NEOFETCH_LOGO" ]; then
        mkdir -p /usr/share/neofetch/ascii
        cp "$NEOFETCH_LOGO" /usr/share/neofetch/ascii/hexarch.txt
        if grep -q "ascii_distro=" /etc/neofetch/config.conf 2>/dev/null; then
            sed -i 's/^ascii_distro=.*/ascii_distro="hexarch"/' /etc/neofetch/config.conf
        else
            echo 'ascii_distro="hexarch"' >> /etc/neofetch/config.conf
        fi
    fi

    # Custom Cursor
    if [ -d "$CUSTOM_CURSOR" ]; then
        cp -r "$CUSTOM_CURSOR" /usr/share/icons/hexarch-cursor
        # Optionally set as default (for X11):
        if [ -f /usr/share/icons/default/index.theme ]; then
            sed -i 's|^Inherits=.*|Inherits=hexarch-cursor|' /usr/share/icons/default/index.theme
        else
            echo '[Icon Theme]' > /usr/share/icons/default/index.theme
            echo 'Inherits=hexarch-cursor' >> /usr/share/icons/default/index.theme
        fi
    fi

    # Wallpapers
    if [ -d "$BRANDING_DIR/wallpapers" ]; then
        # GNOME
        if [ "$DE" = "gnome" ]; then
            mkdir -p /usr/share/backgrounds/hexarch
            cp "$BRANDING_DIR/wallpapers"/* /usr/share/backgrounds/hexarch/
            # Set the first wallpaper as default for GDM and GNOME
            WALLPAPER=$(ls /usr/share/backgrounds/hexarch/* | head -n 1)
            if [ -n "$WALLPAPER" ]; then
                # Set for GDM (login)
                sudo -u gdm dbus-launch gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER" 2>/dev/null || true
                # Set for user (will apply for new users, not existing)
                gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER" 2>/dev/null || true
            fi
        fi
        # KDE Plasma
        if [ "$DE" = "plasma" ]; then
            mkdir -p /usr/share/wallpapers/hexarch
            cp "$BRANDING_DIR/wallpapers"/* /usr/share/wallpapers/hexarch/
            # Set for SDDM (login)
            SDDM_CONF="/usr/share/sddm/themes/breeze/theme.conf.user"
            WALLPAPER=$(ls /usr/share/wallpapers/hexarch/* | head -n 1)
            if [ -n "$WALLPAPER" ]; then
                mkdir -p $(dirname "$SDDM_CONF")
                echo "[General]" > "$SDDM_CONF"
                echo "Background=$WALLPAPER" >> "$SDDM_CONF"
            fi
        fi
        # Hyprland (Wayland)
        if [ "$DE" = "hyprland" ]; then
            mkdir -p /usr/share/backgrounds/hexarch
            cp "$BRANDING_DIR/wallpapers"/* /usr/share/backgrounds/hexarch/
            # User must set in their config, but we provide the wallpapers
        fi
    fi
}

# Enable services
enable_services() {
    systemctl enable NetworkManager
    systemctl enable "$DM"
    systemctl enable --now gamemoded
}

main() {
    echo "Welcome to HexArch OS Conversion Script!"
    choose_pentest_tools
    choose_de
    install_pentest_tools
    install_gaming_packages
    install_performance_tools
    install_zen_kernel
    install_de
    apply_branding
    enable_services
    echo "HexArch OS conversion complete! Reboot to enjoy your new system."
    # Show post-install popup with social handles and GitHub repos
    show_post_install_popup
}

show_post_install_popup() {
    MSG="\nThank you for installing HexArch OS!\n\nConnect with us:\n\nGitHub: https://github.com/NK7m/hexarch-os\nInstagram: https://instagram.com/yourhandle\n\nShare your setup and join the community!\n\n-- Naitik Upadhyay\n"
    if command -v yad &>/dev/null; then
        yad --title="Welcome to HexArch OS" --width=400 --height=250 --center --text="$MSG"
    elif command -v zenity &>/dev/null; then
        zenity --info --title="Welcome to HexArch OS" --width=400 --height=250 --text="$MSG"
    else
        echo -e "$MSG"
    fi
}

main
#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo " Please run this script as root or with sudo."
  exit 1
fi

echo "== Debian Desktop Environment Installer v1.5 =="

# Function to display the menu
show_menu() {
    clear
    echo "===================================="
    echo "  Desktop Environment Installer"
    echo "===================================="
    echo "1. KDE Plasma"
    echo "2. GNOME"
    echo "3. XFCE"
    echo "4. MATE"
    echo "5. Cinnamon"
    echo "6. Exit"
    echo "===================================="
    echo -n "Please enter your choice [1-6]: "
}

install_packages() {
    local packages="$1"
    local name="$2"

    echo "Installing $name..."
    sudo apt update
    if sudo apt install -y $packages; then
        echo " $name installed successfully!"
    else
        echo " Error: $name installation failed." >&2
    fi
}

# Prompt for a Display Manager
read -p "Do you want to install a display manager (login screen)? [y/N]: " install_dm
if [[ $install_dm =~ ^[Yy]$ ]]; then
  echo "Select a display manager:"
  echo "  1) gdm3  (for GNOME)"
  echo "  2) lightdm  (for XFCE/MATE)"
  echo "  3) sddm  (for KDE)"
  read -p "Choice [1-3]: " dm_choice
  case $dm_choice in
    1) sudo apt install -y gdm3 ;;
    2) sudo apt install -y lightdm ;;
    3) sudo apt install -y sddm ;;
    *) echo "Invalid choice. Skipping DM install." ;;
  esac
fi

# Main program
while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            install_packages "kde-plasma-desktop" "KDE Plasma"
            ;;
        2)
            install_packages "gnome" "GNOME"
            ;;
        3)
            install_packages "xfce4" "XFCE"
            ;;
        4)
            install_packages "mate-desktop-environment" "MATE"
            ;;
        5)
            install_packages "cinnamon" "Cinnamon"
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    
    read -p "Press [Enter] to continue..."
done

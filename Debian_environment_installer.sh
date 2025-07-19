#!/bin/bash

# Function to handle script termination (e.g., on Ctrl+C)
cleanup() {
    echo -e "\nInstallation aborted. Exiting."
    exit 1
}

# Trap Ctrl+C (SIGINT) to call the cleanup function
trap cleanup SIGINT

# Function to check for root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Please use 'sudo'."
        exit 1
    fi
}

# Function to update package lists once at the start
update_system() {
    echo "Updating package lists..."
    if ! sudo apt update; then
        echo "Error: Failed to update package lists. Check your internet connection."
        exit 1
    fi
    echo "Package lists updated successfully."
}

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

# Function to install packages with confirmation and error handling
install_packages() {
    local packages="$1"
    local name="$2"
    
    echo "You have chosen to install $name."
    read -p "Are you sure you want to proceed? [Y/n]: " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Starting installation of $name..."
        if sudo apt install -y "$packages"; then
            echo "-----------------------------------"
            echo "$name installed successfully!"
            echo "You may need to reboot your system for changes to take effect."
            echo "-----------------------------------"
        else
            echo "Error occurred during $name installation. Please check the output above for details."
        fi
    else
        echo "Installation of $name cancelled."
    fi
}

#====================================================
# Main program
#====================================================

# Check for root privileges
check_root

# Update the system once before the loop
update_system

while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            install_packages "kde-plasma-desktop" "KDE Plasma"
            ;;
        2)
            install_packages "gnome-core" "GNOME"
            ;;
        3)
            install_packages "xfce4" "XFCE"
            ;;
        4)
            install_packages "mate-desktop-environment" "MATE"
            ;;
        5)
            install_packages "cinnamon-desktop-environment" "Cinnamon"
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

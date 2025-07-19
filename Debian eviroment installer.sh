#!/bin/bash

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

# Function to install packages with error handling
install_packages() {
    local packages="$1"
    local name="$2"
    
    echo "Starting installation of $name..."
    sudo apt update
    if sudo apt install -y $packages; then
        echo "$name installed successfully!"
    else
        echo "Error occurred during $name installation."
        return 1
    fi
}

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
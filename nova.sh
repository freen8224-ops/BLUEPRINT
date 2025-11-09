#!/bin/bash
# -----------------------------------------
# 💎 Rainbow Installer – Fixed Version
# -----------------------------------------

# Install dependencies (figlet + lolcat)
echo "Installing dependencies..."
apt update -y >/dev/null 2>&1
apt install -y figlet lolcat git curl >/dev/null 2>&1

# Clear screen
clear

# Banner
figlet "RAINBOW SETUP" | lolcat
echo "----------------------------------------" | lolcat
echo "      Blueprint + Reviactyl Installer" | lolcat
echo "----------------------------------------" | lolcat
echo ""
sleep 1

# Menu
echo "Select an option:" | lolcat
echo "1) Install Reviactyl Theme" | lolcat
echo "2) Install Blueprint Framework" | lolcat
echo "3) Exit" | lolcat
echo ""
read -p "Enter option number: " choice

case $choice in
  1)
    clear
    figlet "Reviactyl" | lolcat
    echo "Installing Reviactyl theme..." | lolcat
    cd /var/www || exit
    rm -rf reviactyl
    git clone https://github.com/Reviactyl/Reviactyl.git reviactyl
    echo "✅ Reviactyl Theme Installed Successfully!" | lolcat
    ;;

  2)
    clear
    figlet "Blueprint" | lolcat
    echo "Installing Blueprint framework..." | lolcat
    cd /var/www || exit
    rm -rf BLUEPRINT
    git clone https://github.com/freen8224-ops/BLUEPRINT.git
    echo "✅ Blueprint Installed Successfully!" | lolcat
    ;;

  3)
    clear
    figlet "Goodbye!" | lolcat
    echo "Exiting setup... Have a great day!" | lolcat
    exit 0
    ;;

  *)
    echo "❌ Invalid option! Try again." | lolcat
    ;;
esac

echo ""
echo "----------------------------------------" | lolcat
echo " 💜 Installation Complete!" | lolcat
echo "----------------------------------------" | lolcat

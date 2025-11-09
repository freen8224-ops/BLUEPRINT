#!/bin/bash
# =========================================================
# 🌈 NOVA AUTO INSTALLER for Pterodactyl + Reviactyl Theme
# =========================================================
# Made with ❤️ by Valayar Hosting (freen8224-ops)
# =========================================================

# --- Auto install figlet & lolcat if missing ---
echo "🧩 Checking required packages..."
apt update -y > /dev/null 2>&1
apt install -y figlet ruby curl wget unzip git gnupg zip ca-certificates > /dev/null 2>&1
gem install lolcat > /dev/null 2>&1

# --- Display NOVA banner ---
clear
figlet "NOVA" | lolcat
echo "=========================================================" | lolcat
echo "🚀 Pterodactyl + Reviactyl + Blueprint Auto Installer 🌈" | lolcat
echo "=========================================================" | lolcat
echo ""
echo "Select an option:" | lolcat
echo "  [1] 🌌 Install Reviactyl Theme" | lolcat
echo "  [2] 🧩 Install Blueprint Framework" | lolcat
echo "  [0] ❌ Exit" | lolcat
echo ""
read -p "➡️  Enter option number: " option

# ==============================
# Option 1: Install Reviactyl
# ==============================
if [ "$option" == "1" ]; then
    clear
    figlet "Reviactyl" | lolcat
    echo "🚧 Installing Reviactyl Theme..." | lolcat
    sleep 1
    cd /var/www/pterodactyl || { echo "❌ Directory not found!" | lolcat; exit 1; }

    rm -rf *
    curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache/

    COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
    php artisan migrate --seed --force

    chown -R www-data:www-data /var/www/pterodactyl/*
    systemctl restart pteroq.service

    echo ""
    echo "============================================" | lolcat
    echo "✅ Reviactyl Installed Successfully!" | lolcat
    echo "🌌 Welcome to the NOVA Themed Environment" | lolcat
    echo "============================================" | lolcat

# ==============================
# Option 2: Install Blueprint
# ==============================
elif [ "$option" == "2" ]; then
    clear
    figlet "Blueprint" | lolcat
    echo "📦 Installing Blueprint Framework..." | lolcat
    sleep 1
    export PTERODACTYL_DIRECTORY=/var/www/pterodactyl

    apt install -y curl wget unzip ca-certificates git gnupg zip > /dev/null 2>&1

    cd $PTERODACTYL_DIRECTORY || { echo "❌ Directory not found!" | lolcat; exit 1; }
    wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O $PTERODACTYL_DIRECTORY/release.zip
    unzip -o release.zip

    mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
    apt update > /dev/null 2>&1
    apt install -y nodejs > /dev/null 2>&1

    npm i -g yarn > /dev/null 2>&1
    yarn install

    cat <<EOF > $PTERODACTYL_DIRECTORY/.blueprintrc
WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";
EOF

    chmod +x $PTERODACTYL_DIRECTORY/blueprint.sh
    bash $PTERODACTYL_DIRECTORY/blueprint.sh

    echo ""
    echo "============================================" | lolcat
    echo "✅ Blueprint Framework Installed!" | lolcat
    echo "🌈 NOVA Auto Installer completed successfully!" | lolcat
    echo "============================================" | lolcat

# ==============================
# Option 0: Exit
# ==============================
elif [ "$option" == "0" ]; then
    echo "👋 Exiting NOVA Installer..." | lolcat
    exit 0

# ==============================
# Invalid Option
# ==============================
else
    echo "❌ Invalid option. Please run again." | lolcat
fi

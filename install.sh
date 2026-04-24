#!/bin/bash

# ----------------------------------
# Clytrix Smart AAPanel Installer v3.0
# ----------------------------------

# Colors
NC='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'

# Logging
LOG_FILE="/root/aapanel-install.log"
exec > >(tee -i $LOG_FILE)
exec 2>&1

clear
echo "======================================"
echo "    CL AAPANEL INSTALLER v3.0"
echo "======================================"
sleep 1

# ----------------------------------
# Root Check
# ----------------------------------
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Run this script as ROOT${NC}"
  exit 1
fi

# ----------------------------------
# OS Detection
# ----------------------------------
echo -e "${CYAN}Detecting OS...${NC}"
. /etc/os-release
OS=$ID
VER=$VERSION_ID

echo -e "${GREEN}OS: $OS $VER${NC}"

# ----------------------------------
# Server Stats
# ----------------------------------
echo ""
echo -e "${CYAN}Server Stats:${NC}"

CPU=$(nproc)
RAM=$(free -m | awk '/Mem:/ {print $2}')
DISK=$(df -h / | awk 'NR==2 {print $2}')

echo "CPU Cores : $CPU"
echo "RAM       : ${RAM} MB"
echo "Disk      : $DISK"

# ----------------------------------
# Low RAM Fix (Swap)
# ----------------------------------
if [ "$RAM" -lt 1024 ]; then
    echo -e "${YELLOW}Low RAM detected. Creating Swap...${NC}"
    fallocate -l 1G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi

# ----------------------------------
# Network Check
# ----------------------------------
echo ""
echo -e "${CYAN}Checking Network...${NC}"

if ping -c 1 google.com >/dev/null 2>&1; then
    echo -e "${GREEN}Internet OK${NC}"
else
    echo -e "${YELLOW}Fixing DNS...${NC}"
    echo "nameserver 8.8.8.8" > /etc/resolv.conf
    echo "nameserver 1.1.1.1" >> /etc/resolv.conf
fi

# ----------------------------------
# Package Install
# ----------------------------------
echo ""
echo -e "${CYAN}Updating System...${NC}"

case $OS in
    ubuntu|debian)
        apt update -y && apt upgrade -y
        apt install -y curl wget sudo
        ;;
    centos|rocky|almalinux)
        yum update -y
        yum install -y curl wget sudo
        ;;
    *)
        echo -e "${RED}Unsupported OS${NC}"
        exit 1
        ;;
esac

# ----------------------------------
# Security Checks
# ----------------------------------
echo ""
echo -e "${CYAN}Security Checks:${NC}"

systemctl is-active --quiet firewalld && echo -e "${YELLOW}Firewalld Active${NC}"
systemctl is-active --quiet ufw && echo -e "${YELLOW}UFW Active${NC}"
selinuxenabled && echo -e "${RED}SELinux Enabled (May cause issues)${NC}"

# ----------------------------------
# Install Menu
# ----------------------------------
echo ""
echo -e "${CYAN}Choose Installation Type:${NC}"
echo "1) Free AAPanel"
echo "2) Free + OpenClaw"
echo "3) Pro AAPanel"

read -p "Enter choice [1-3]: " CHOICE

# ----------------------------------
# Install Functions
# ----------------------------------

install_free() {
    URL=https://www.aapanel.com/script/install_panel_en.sh
    curl -ksSO $URL || wget --no-check-certificate -O install_panel_en.sh $URL
    bash install_panel_en.sh ipssl
}

install_openclaw() {
    URL=https://www.aapanel.com/script/aaClaw.sh
    curl -ksSO $URL || wget --no-check-certificate -O aaClaw.sh $URL
    bash aaClaw.sh 9e7f1eae
}

install_pro() {
    URL=https://www.aapanel.com/script/install_pro_en.sh
    curl -ksSO $URL || wget --no-check-certificate -O install_pro_en.sh $URL
    bash install_pro_en.sh aa372544
}

# ----------------------------------
# Run Installation
# ----------------------------------
echo ""
echo -e "${CYAN}Starting Installation...${NC}"

case $CHOICE in
    1)
        echo -e "${GREEN}Installing Free Version...${NC}"
        install_free
        ;;
    2)
        echo -e "${GREEN}Installing Free + OpenClaw...${NC}"
        install_free
        install_openclaw
        ;;
    3)
        echo -e "${GREEN}Installing Pro Version...${NC}"
        install_pro
        ;;
    *)
        echo -e "${RED}Invalid Choice${NC}"
        exit 1
        ;;
esac

# ----------------------------------
# Final Output
# ----------------------------------
IP=$(curl -s https://api.ipify.org)

echo ""
echo "======================================"
echo -e "${GREEN}INSTALLATION COMPLETED 🚀${NC}"
echo "======================================"

echo -e "Panel URL : ${CYAN}http://$IP:8888${NC}"
echo -e "Log File  : ${YELLOW}$LOG_FILE${NC}"
echo ""
echo -e "${GREEN}Your server is now ready like a loaded spaceship.${NC}"
echo -e "Support: info@clytrix.com"
echo "======================================"

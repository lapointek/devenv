#!/bin/bash

# Exit if any code returns a non-zero exit code
set -e

source utils.sh

echo "Starting full system setup..."

# Check if packages.conf exist
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi
source packages.conf

# Update system
echo "Updating System..."
sudo pacman -Syu

# Install paru AUR helper
if ! command -V paru &>/dev/null; then
  echo "Installing paru AUR helper..."
  sudo pacman -S --needed git base-devel --noconfirm
  if [[ ! -d "paru" ]]; then
    echo "Cloning paru repo..."
  else
    echo "paru directory already exists, removing it..."
    rm -rf paru
  fi
  git clone https://aur.archlinux.org/paru.git
  cd paru
  echo "building paru..."
  makepkg -si
  cd ..
  rm -rf paru
else
  echo "paru is already installed"
fi

# Install system packages
echo "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing dev tools..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing system maintenance tools..."
install_packages "${MAINTENANCE[@]}"

echo "Installing desktop applications..."
install_packages "${DESKTOP[@]}"

echo "Installing media applications..."
install_packages "${MEDIA[@]}"

echo "Installing fonts..."
install_packages "${FONTS[@]}"

# Start and enable system services
echo "Configuring services..."
for service in "${SERVICES[@]}"; do
  if ! systemctl is-enabled "$service" &>/dev/null; then
    echo "Enabling $service..."
    sudo systemctl enable --now "$service"
  else
    echo "$service is already enabled"
  fi
done

echo "Rebuilding man pages database..."
sudo mandb --create --quiet --noconfirm

echo "Enabling ufw on startup..."
sudo ufw enable --noconfirm

# Retrieve latest mirror list
echo "Retrieving latest mirror list..."
sudo reflector --country "Canada,United States" --protocol https --score 50 --fastest 10 --sort rate --save /etc/pacman.d/mirrorlist

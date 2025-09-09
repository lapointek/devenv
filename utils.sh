#!/bin/bash

is_installed() {
  pacman -Qi "$1" &>/dev/null
}

is_group_installed() {
  pacman -Qg "$1" &>/dev/null
}

install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg" && ! is_group_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    sudo pacman -S --noconfirm "${to_install[@]}"
  fi
}

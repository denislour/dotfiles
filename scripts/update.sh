#!/usr/bin/env bash
set -e

cd /etc/nixos
sudo git pull
sudo nixos-rebuild switch --flake /etc/nixos#my-vm

# Keep only latest 1 generation, then garbage collect
echo "=== Cleaning old generations (keeping last 1) ==="
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
nix-env --delete-generations +1 2>/dev/null || true
sudo nix-collect-garbage

sudo reboot

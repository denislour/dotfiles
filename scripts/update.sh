#!/usr/bin/env bash
set -e

cd /etc/nixos
sudo git pull
sudo nixos-rebuild switch --flake /etc/nixos#my-vm

# Keep only latest 2 generations, then garbage collect
echo "=== Cleaning old generations (keeping last 2) ==="
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
nix-env --delete-generations +2 2>/dev/null || true
sudo nix-collect-garbage

sudo reboot

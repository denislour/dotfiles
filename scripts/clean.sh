#!/usr/bin/env bash
set -e

echo "=== Keeping latest 2 system generations ==="
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2

echo "=== Keeping latest 2 home-manager generations ==="
nix-env --delete-generations +2 2>/dev/null || true

echo "=== Running garbage collector ==="
sudo nix-collect-garbage

echo "=== Done ==="
echo ""
echo "Current generations:"
sudo nix-env -p /nix/var/nix/profiles/system --list-generations

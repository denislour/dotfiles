#!/usr/bin/env bash
set -e

cd /etc/nixos
sudo git pull
sudo nixos-rebuild switch --flake /etc/nixos#my-vm
sudo reboot

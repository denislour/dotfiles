# NixOS dotfiles

NixOS configuration with Hyprland desktop for VMware Workstation 17 Pro.

## VM settings

| Setting | Value |
|---------|-------|
| OS | NixOS (Minimal ISO) |
| Processors | 4 CPU, bật VT-x |
| RAM | 8GB |
| Disk | 20GB (NVMe or SCSI) |
| Network | NAT |
| Display | Accelerate 3D: OFF |

## Installation

Boot NixOS Minimal ISO. At GRUB menu, select **Install LTS**.

```bash
# 1. Check network (NAT auto DHCP)
ping -c1 google.com

# 2. Clone dotfiles
git clone https://github.com/denislour/dotfiles.git /mnt/etc/nixos

# 3. Clone disko locally (avoids GitHub API 404 in VM)
git clone https://github.com/nix-community/disko /tmp/disko

# 4. Run disko — format & mount partitions
sudo nix run /tmp/disko \
  --extra-experimental-features "nix-command flakes" -- \
  --mode disko /mnt/etc/nixos/hosts/my-vm/disk-config.nix

# 5. Generate hardware config (unique per machine, not in git)
nixos-generate-config --root /mnt \
  --show-hardware-config > /mnt/etc/nixos/hosts/my-vm/hardware-configuration.nix

# 6. Install NixOS
nixos-install --flake /mnt/etc/nixos#my-vm

# 7. Reboot (eject ISO)
reboot
```

## First boot

- Login: `jake` / `changeme`
- Change password: `passwd`
- Rebuild: `sudo nixos-rebuild switch --flake /etc/nixos#my-vm`

## After install (optional)

```bash
# Update all packages
sudo nix flake update
sudo nixos-rebuild switch --flake /etc/nixos#my-vm

# Clean old generations
sudo nix-collect-garbage -d
```

## Keybinds

| Key | Action |
|-----|--------|
| Super + Q | Terminal (kitty) |
| Super + R | App launcher (rofi) |
| Super + W | Close window |
| Super + F | Toggle fullscreen |
| Super + Space | Toggle floating |
| Super + arrows | Focus window |
| Super + Shift + arrows | Move window |
| Print | Screenshot area |
| Volume keys | Adjust volume |

## Notes

- `hardware-configuration.nix` is auto-generated per machine — not tracked in git
- Use initial password `changeme` on first boot, change it immediately
- All config is in Nix language — edit files in `modules/` then rebuild

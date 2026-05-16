# NixOS dotfiles

NixOS configuration with Hyprland desktop for VMware VM.

## Quick start

Boot NixOS Minimal ISO, then:

```bash
ping -c1 google.com
nix-shell -p git
git clone <your-repo-url> /mnt/etc/nixos

nix run github:nix-community/disko -- \
  --mode disko /mnt/etc/nixos/hosts/my-vm/disk-config.nix

nixos-generate-config --root /mnt \
  --show-hardware-config > /mnt/etc/nixos/hosts/my-vm/hardware-configuration.nix

nixos-install --flake /mnt/etc/nixos#my-vm

reboot
```

## First boot

- Login: `jake` / `changeme`
- Change password: `passwd`
- Rebuild config: `sudo nixos-rebuild switch --flake /etc/nixos#my-vm`

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

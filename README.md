# NixOS dotfiles

NixOS + Hyprland (from nixpkgs) for VMware Workstation 17 Pro.

## VM Settings

| Setting | Value |
|---------|-------|
| Firmware | UEFI |
| 3D Acceleration | **ON** |
| CPUs | 4 |
| RAM | 8 GB |
| Disk | 40 GB |

### .vmx

```
keyboard.vusb.enable = "TRUE"
```

---

## Installation

```bash
# Partition
curl -L "https://raw.githubusercontent.com/denislour/dotfiles/master/hosts/my-vm/disk-config.nix" -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/disk-config.nix

# Clone + install
nix-shell -p git
sudo git clone https://github.com/denislour/dotfiles /mnt/etc/nixos
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/my-vm/
sudo nixos-install --flake /mnt/etc/nixos#my-vm --max-jobs 1 --cores 1
sudo reboot
```

---

## First Boot

`jake` / `changeme` → SDDM → Hyprland.

---

## Minimal Keybinds

| Key | Action |
|-----|--------|
| `Super + Q` | Terminal (kitty) |
| `Super + R` | App launcher (rofi) |
| `Super + W` | Close window |
| `Super + arrows` | Focus / Move |
| `Super + 1-9` | Switch workspace |
| `Print` | Screenshot |

---

## Structure

```
├── flake.nix
├── hosts/my-vm/
│   ├── configuration.nix
│   └── disk-config.nix
├── modules/
│   ├── common.nix
│   └── desktop.nix
└── home-manager/
    └── home.nix
```

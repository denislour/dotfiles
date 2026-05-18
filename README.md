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
# 1. Partition
curl -L "https://raw.githubusercontent.com/denislour/dotfiles/master/hosts/my-vm/disk-config.nix" -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/disk-config.nix

# 2. Create nix dir on real disk & bind (tmpfs is only ~4GB)
sudo mkdir -p /mnt/nix
sudo mount --bind /mnt/nix /nix

# 3. Clone repo
nix-shell -p git
sudo git clone https://github.com/denislour/dotfiles /mnt/etc/nixos

# 4. Generate hardware config
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/my-vm/

# 5. Install
sudo nixos-install --flake /mnt/etc/nixos#my-vm --max-jobs 1 --cores 1

# 6. Reboot (eject ISO)
sudo reboot
```

---

## First Boot

`jake` / `changeme` → SDDM → Hyprland.

---

## Keybinds

| Key | Action |
|-----|--------|
| `Super + Q` | Terminal (foot) |
| `Super + W` | Close window |

Add more in `home-manager/home.nix` → `wayland.windowManager.hyprland.settings.bind`.

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

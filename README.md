# NixOS dotfiles

NixOS + Niri for VMware Workstation 17 Pro.

## VM Settings

| Setting | Value |
|---------|-------|
| Guest OS | Linux → Other Linux 6.x kernel 64-bit |
| CPUs | 4 |
| RAM | 8 GB |
| Disk | 40 GB |
| Network | NAT |
| Firmware | UEFI |
| 3D Acceleration | **ON** |

### .vmx tweak

Add to `.vmx` to fix keyboard lag:

```
keyboard.vusb.enable = "TRUE"
```

---

## Installation

Boot the **NixOS Minimal ISO**.

```bash
# 1. Check network
ping -c 1 google.com

# 2. Download disko config & partition
curl -L "https://raw.githubusercontent.com/denislour/dotfiles/master/hosts/my-vm/disk-config.nix" -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/disk-config.nix

# 3. Clone repo
nix-shell -p git
sudo git clone https://github.com/denislour/dotfiles /mnt/etc/nixos

# 4. Generate hardware config
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/my-vm/

# 5. Install (limit jobs to avoid OOM)
sudo nixos-install --flake /mnt/etc/nixos#my-vm --max-jobs 2 --cores 2

# 6. Reboot (eject ISO)
sudo reboot
```

### If "no space left on device"

After failed builds, the store accumulates garbage:

```bash
sudo rm -rf /mnt/nix/store/*
sudo nixos-install --flake /mnt/etc/nixos#my-vm --max-jobs 2 --cores 2
```

---

## First Boot

| User | Password |
|------|----------|
| `jake` | `changeme` |

```bash
# Change password immediately
passwd
```

SDDM → Niri → Waybar appears.

---

## Keybinds

| Key | Action |
|-----|--------|
| `Super + Q` | Terminal (kitty) |
| `Super + R` | App launcher (rofi) |
| `Super + W` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + arrows` | Focus (H/J/K/L) |
| `Super + Shift + arrows` | Move window |
| `Super + 1-5` | Switch workspace |
| `Super + Shift + 1-5` | Move window to workspace |
| `Super + Shift + E` | Quit Niri |
| `Print` | Screenshot |
| Volume keys | Adjust volume |

---

## Project Structure

```
dotfiles/
├── flake.nix
├── hosts/
│   └── my-vm/
│       ├── configuration.nix
│       ├── disk-config.nix
│       └── hardware-configuration.nix (auto-generated)
├── modules/
│   ├── common.nix
│   ├── desktop.nix
│   └── development.nix
└── home-manager/
    └── home.nix
```

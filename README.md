# NixOS dotfiles

NixOS + Hyprland for VMware Workstation 17 Pro.

## VM Settings

| Setting | Value |
|---------|-------|
| Guest OS | Linux → Other Linux 6.x kernel 64-bit |
| CPUs | 4 |
| RAM | 8 GB |
| Disk | 40 GB (SCSI or SATA) |
| Network | NAT |
| Firmware | UEFI |
| 3D Acceleration | **ON** (required for Hyprland) |

### .vmx tweak

Add this line to your `.vmx` file to fix keyboard lag in TTY:

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

# 3. Clone repo to persistent storage
nix-shell -p git
sudo git clone https://github.com/denislour/dotfiles /mnt/etc/nixos

# 4. Generate hardware config
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/my-vm/

# 5. Install (limit 1 job + 1 core to save RAM)
sudo nixos-install --flake /mnt/etc/nixos#my-vm --max-jobs 1 --cores 1

# 6. Reboot (eject ISO)
sudo reboot
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

SDDM → Hyprland → Waybar + kitty.

---

## Keybinds

| Key | Action |
|-----|--------|
| `Super + Q` | Terminal (kitty) |
| `Super + R` | App launcher (rofi) |
| `Super + W` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + Space` | Toggle floating |
| `Super + arrows` | Focus window |
| `Super + Shift + arrows` | Move window |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |
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
│       └── hardware-configuration.nix (auto-generated, untracked)
├── modules/
│   ├── common.nix
│   ├── desktop.nix
│   └── development.nix
└── home-manager/
    └── home.nix
```

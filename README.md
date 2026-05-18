# NixOS dotfiles

NNN Stack: **N**ixOS + **N**iri + **N**octalia for VMware Workstation 17 Pro.

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

## Installation

```bash
# 1. Partition
curl -L "https://raw.githubusercontent.com/denislour/dotfiles/master/hosts/my-vm/disk-config.nix" -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/disk-config.nix

# 2. Create nix dir on real disk & bind
sudo mkdir -p /mnt/nix
sudo mount --bind /mnt/nix /nix

# 3. Re-enter nix-shell
nix-shell -p git sudo

# 4. Clone repo
sudo git clone https://github.com/denislour/dotfiles /mnt/etc/nixos

# 5. Generate hardware config
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/my-vm/

# 6. Install
sudo nixos-install --flake /mnt/etc/nixos#my-vm --max-jobs 1 --cores 1

# 7. Reboot
sudo reboot
```

## First Boot

- User: `jake` / `changeme`
- Greetd tự động login → Niri → Noctalia
- Terminal: `Super+Return` (ghostty)

## Seasoning

| Tool | What |
|------|------|
| `eza` | `ls` đẹp hơn |
| `bat` | `cat` có màu |
| `fd` | `find` nhanh hơn |
| `rg` | `grep` siêu tốc |
| `delta` | `diff` đẹp |
| `btm` | `top` hiện đại |
| `dust` | `du` trực quan |
| `procs` | `ps` dễ đọc |
| `atuin` | Lịch sử lệnh có search |
| `starship` | Prompt zsh đẹp |
| `zoxide` | `cd` thông minh |

## Keybinds

| Key | Action |
|-----|--------|
| `Super+Return` | Terminal (ghostty) |
| `Super+Space` / `Super+r` | Noctalia launcher |
| `Super+q` | Close window |
| `Super+f` | Fullscreen |
| `Super+t` | Toggle floating |
| `Super+m` | Quit niri |
| `Super+h/j/k/l` | Focus direction |
| `Super+Shift+h/j/k/l` | Move window |
| `Super+1-5` | Switch workspace |
| `Super+Shift+1-5` | Move to workspace |
| `Super+Shift+q` | Lock screen |
| `Print` | Screenshot area |

## Secrets

Sops-nix với age key. Tạo key lần đầu:
```bash
age-keygen -o ~/.config/sops/age/keys.txt
sops secrets/secrets.yaml
```

## Structure

```
├── flake.nix
├── system/              ← System-level config
│   ├── common.nix
│   ├── environment.nix
│   ├── packages.nix
│   ├── services/
│   │   ├── greetd.nix
│   │   ├── sops.nix
│   │   └── ssh.nix
│   ├── programs/
│   │   ├── stylix.nix
│   │   └── xdg-portal.nix
│   └── wallpapers/
├── home/                ← User-level config
│   ├── niri/
│   │   ├── settings.nix
│   │   ├── keybinds.nix
│   │   ├── autostart.nix
│   │   ├── noctaliashell.nix
│   │   └── rules.nix
│   └── programs/
│       ├── atuin.nix, bat.nix, bottom.nix, ...
│       ├── ghostty.nix, git.nix
│       ├── pi.nix
│       ├── starship.nix, zsh.nix
│       └── ...
└── hosts/my-vm/
    ├── configuration.nix
    ├── home.nix
    ├── packages.nix
    └── disk-config.nix
```

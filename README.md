# NixOS dotfiles

NNN Stack: **N**ixOS + **N**iri + **N**octalia on VMware Workstation 17 Pro.

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

# 2. Mount real disk for /nix (tmpfs is ~4GB only)
sudo mkdir -p /mnt/nix
sudo mount --bind /mnt/nix /nix

# 3. Re-enter nix-shell
nix-shell -p git sudo

# 4. Clone repo
sudo git clone git@github.com:denislour/dotfiles /mnt/etc/nixos

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
- Greetd auto-login → Niri → Noctalia
- Open terminal: `Alt+Return` (ghostty)

## Features

### Desktop shell — Noctalia

- Floating pill-shaped bar at top (iPhone Dynamic Island style)
- Auto-hide dock at bottom (macOS-like)
- Catppuccin Lavender color scheme
- Noctalia launcher: `Alt+Space` / `Alt+r`
- Lock screen: `Alt+Shift+q`
- Volume/media OSD via Noctalia

### Terminal — Ghostty

- JetBrainsMono Nerd Font, 11px
- Catppuccin Lavender theme
- Transparent background (0.95)
- No window decorations

### Editor — Neovim + AstroNvim

- AstroNvim template with custom community plugins
- LSPs: rust-analyzer, pyright, solargraph
- Relative line numbers
- Default shell editor

### AI coding — pi

- DeepSeek V4 (flash/pro) models
- Phin themes (robusta dark, arabica light)
- Custom skills: web-search, nix-style

### File management — Yazi

- Terminal file manager with image preview
- `yy` shell wrapper for cwd opening
- Hotkeys: `gn` (sizes), `gm` (mtime), `gp` (permissions)

## Tools

| Tool | Replaces | Why |
|------|----------|-----|
| `eza` | `ls` | Colors, icons, git status |
| `bat` | `cat` | Syntax highlighting |
| `fd` | `find` | Faster, intuitive |
| `rg` | `grep` | Blazing fast code search |
| `delta` | `diff` | Side-by-side diffs |
| `btm` | `top` | TUI with charts |
| `dust` | `du` | Visual disk usage |
| `procs` | `ps` | Human-readable processes |
| `atuin` | `history` | Ctrl+R with fuzzy search |
| `starship` | prompt | Minimal, fast prompt |
| `zoxide` | `cd` | Smart directory jumping |

## Keybinds

| Key | Action |
|-----|--------|
| `Alt+Return` | Terminal (ghostty) |
| `Alt+Space` / `Alt+r` | Noctalia launcher |
| `Alt+q` | Close window |
| `Alt+f` | Fullscreen |
| `Alt+t` | Toggle floating |
| `Alt+m` | Quit niri |
| `Alt+o` | Toggle overview |
| `Alt+h/j/k/l` | Focus direction |
| `Alt+Shift+h/j/k/l` | Move column |
| `Alt+1-5` | Switch workspace |
| `Alt+Shift+1-5` | Move column to workspace |
| `Alt+Shift+q` | Lock screen |
| `Print` | Screenshot area |
| `Ctrl+Print` | Screenshot screen |
| `Alt+Print` | Screenshot window |

## Secrets

Managed with sops-nix + age. First-time setup:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
sops secrets/secrets.yaml
```

## Structure

```
├── flake.nix
├── system/              ← System-level (NixOS)
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
├── home/                ← User-level (home-manager)
│   ├── niri/
│   │   ├── settings.nix
│   │   ├── keybinds.nix
│   │   ├── autostart.nix
│   │   ├── noctaliashell.nix
│   │   └── rules.nix
│   └── programs/
│       ├── astronvim/
│       ├── atuin.nix, bat.nix, bottom.nix, ...
│       ├── ghostty.nix, git.nix
│       ├── pi/
│       ├── starship.nix, zsh.nix
│       └── ...
└── hosts/my-vm/
    ├── configuration.nix
    ├── home.nix
    ├── packages.nix
    └── disk-config.nix
```

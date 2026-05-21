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

- JetBrainsMono Nerd Font, 18px
- Catppuccin Mocha theme
- Transparent background (0.95)
- No window decorations

### Editor — Neovim + AstroNvim

- AstroNvim template with custom community plugins
- LSPs: rust-analyzer, pyright, solargraph
- Community packs: rust, python, ruby
- File explorer: yazi-nvim (`<leader>yy`), neo-tree (hidden files visible, transparent)
- Colorscheme: carbonfox (nightfox)
- Relative line numbers
- Default shell editor

### IDE — Zed

- Catppuccin Mocha icons theme
- Panels: project, outline, git on left; agent on right
- LSPs: rust-analyzer, pyright, marksman, nil (alejandra formatter)
- Carbonfox - opaque theme
- DeepSeek agent

### AI coding — pi

- DeepSeek V4 (flash/pro) models
- Phin themes (robusta dark, arabica light)
- Custom skills: web-search, nix-style
- Caveman extension (ultra-compressed communication)

### Browser — LibreWolf

- Dark mode forced (prefers-color-scheme override)
- Fingerprinting protection with CSS color scheme exception
- Cookies persist across restarts
- Privacy-hardened defaults

### File management — Yazi

- Terminal file manager with image preview
- `y` shell wrapper for cwd opening
- Show hidden files
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
| `lazygit` | `git` | TUI git client |
| `glow` | `man` | Markdown renderer |

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

## Quick Commands

```bash
just rebuild    # nixos-rebuild only (no gc, no reboot)
just update     # git pull + rebuild + gc + reboot
just upgrade    # nix flake update + rebuild + gc + reboot
```

## Secrets

Managed with sops-nix + age. First-time setup:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
sops secrets/secrets.yaml
```

Secrets stored in `/run/secrets/`:
- `deepseek_api_key`
- `brave_search_api_key`

## Structure

```
├── flake.nix
├── justfile
├── system/              ← System-level (NixOS)
│   ├── common.nix       ← nix-ld, flakes, GC
│   ├── environment.nix
│   ├── packages.nix
│   ├── services/
│   │   ├── greetd.nix
│   │   ├── sops.nix
│   │   └── ssh.nix
│   ├── programs/
│   │   ├── stylix.nix    ← dark theme, fonts
│   │   └── xdg-portal.nix
│   └── wallpapers/
├── home/                ← User-level (home-manager)
│   ├── niri/             ← Wayland compositor
│   │   ├── settings.nix
│   │   ├── keybinds.nix
│   │   ├── autostart.nix
│   │   ├── noctaliashell.nix
│   │   └── rules.nix
│   └── programs/
│       ├── astronvim/    ← Neovim + plugins
│       │   ├── default.nix
│       │   └── lua/
│       │       ├── community.lua
│       │       ├── options.lua
│       │       └── plugins/
│       │           ├── neo-tree.lua
│       │           ├── nightfox.lua
│       │           └── yazi.lua
│       ├── librewolf/   ← Browser config
│       │   ├── default.nix
│       │   └── overrides.cfg
│       ├── pi/          ← AI coding agent
│       │   ├── default.nix
│       │   └── agent/
│       │       ├── models.nix
│       │       └── settings.nix
│       ├── zed-editor/  ← Zed IDE
│       │   └── default.nix
│       ├── ghostty.nix, git.nix, starship.nix, ...
│       └── ...
└── hosts/my-vm/
    ├── configuration.nix
    ├── home.nix
    ├── packages.nix
    └── disk-config.nix
```

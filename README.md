# NixOS dotfiles

NNN Stack: **N**ixOS + **N**iri + **N**octalia on VMware Workstation 17 Pro (Wayland)
Also available: **N**ixOS + **B**SPWM on X11 for compatibility.

## Screenshot

![Desktop screenshot](images/desktop-screenshot.png)

## Hosts

| Host | Desktop | WM | Purpose |
|------|---------|----|---------|
| `my-vm` | Wayland | Niri + Noctalia | Primary daily driver |
| `my-vm-x11` | X11 | BSPWM + sxhkd | Fallback for guests without 3D acceleration |

## VM Settings (my-vm)

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

### Partition + Install

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
- Greetd auto-login → Niri (wayland) or LightDM → BSPWM (x11)
- Open terminal: `Alt+Return` (Ghostty on wayland, ghostty on x11)

## Features

### Desktop Shell — Noctalia (Wayland)

- Floating pill-shaped bar at top (iPhone Dynamic Island style)
- Auto-hide dock at bottom (macOS-like)
- Ayu color scheme
- Launcher: `Alt+Space` / `Alt+r`
- Lock screen: `Alt+Shift+q`
- Volume/media OSD via Noctalia

### Desktop — BSPWM (X11)

- LightDM display manager
- Rofi launcher (`Alt+Space` / `Alt+d`)
- sxhkd keybindings (same navigation: hjkl)
- picom compositor, feh wallpaper, dunst notifications

### Terminal — Ghostty

- JetBrainsMono Nerd Font, 18px
- Catppuccin Mocha theme
- Transparent background (0.95)
- No window decorations
- Shell integration with Zsh

### Editor — Neovim + AstroNvim

- AstroNvim template with custom community plugins
- LSPs: rust-analyzer, pyright, solargraph, liger (crystal), mint
- Community packs: rust, python, ruby, zig
- File explorer: yazi-nvim (`<leader>yy`), neo-tree (hidden files visible, transparent)
- Colorscheme: carbonfox (nightfox), transparent background
- Relative line numbers, soft wrap
- Crystal lang: liger LSP + ameba linting on save
- Mint lang: mint LSP
- Default shell editor (`EDITOR=nvim`)

### IDE — Zed

- Catppuccin Mocha icons theme
- Panels: project, outline, git on left; agent on right
- LSPs: rust-analyzer, pyright, marksman, nil (alejandra formatter)
- Theme: Duskfox (dark) / Dayfox (light)
- DeepSeek agent with tool permissions
- Brave Search MCP server

### AI Coding — pi

- DeepSeek V4 Flash (default) / V4 Pro models
- Phin themes: robusta (dark), arabica (light)
- Custom skills: nix-style, web-search, caveman, design-systems
- Caveman extension: `/caveman` for ultra-compressed replies
- DS Balance extension: `/ds-balance` to check DeepSeek account
- DeepSeek API key from sops-nix at `/run/secrets/deepseek_api_key`

### Browser — Brave

- Dark mode forced (`--force-dark-mode`)
- Ozone platform hint auto (Wayland native)
- Device scale factor 1.25
- Catppuccin Mocha theme via Stylix

### File Management — Yazi

- Terminal file manager with image preview
- `yy` shell wrapper for cwd opening
- Show hidden files
- Hotkeys: `gn` (sizes), `gm` (mtime), `gp` (permissions)
- Sort by natural order, dirs first

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
| `atuin` | `history` | Ctrl+R with fuzzy search (replaces Zsh history) |
| `starship` | prompt | Minimal, fast prompt |
| `zoxide` | `cd` | Smart directory jumping |
| `lazygit` | `git` | TUI git client |
| `glow` | markdown | Terminal markdown renderer |

## Keybinds (Wayland — Niri)

| Key | Action |
|-----|--------|
| `Alt+Return` | Terminal (ghostty) |
| `Alt+Space` | Noctalia launcher |
| `Alt+q` | Close window |
| `Alt+f` | Fullscreen |
| `Alt+t` | Toggle floating |
| `Alt+o` | Toggle overview |
| `Alt+h/j/k/l` | Focus direction |
| `Alt+Shift+h/j/k/l` | Move column |
| `Alt+1-5` | Switch workspace |
| `Alt+Shift+1-5` | Move column to workspace |
| `Alt+Shift+q` | Lock screen |
| `Print` | Screenshot area |
| `Ctrl+Print` | Screenshot screen |
| `Alt+Print` | Screenshot window |
| `Alt+comma` | Toggle settings |
| `Alt+minus/equal` | Preset column width back/next |
| `XF86Audio*` | Volume (raise/lower/mute), media (play/next/prev) |

## Keybinds (X11 — BSPWM)

| Key | Action |
|-----|--------|
| `Alt+Return` | Terminal (ghostty) |
| `Alt+Space` / `Alt+d` | Rofi app launcher |
| `Alt+q` / `Alt+F4` | Close window |
| `Alt+f` | Fullscreen |
| `Alt+t` / `Alt+s` | Toggle tiled/floating |
| `Alt+h/j/k/l` | Focus west/south/north/east |
| `Alt+Shift+h/j/k/l` | Move window direction |
| `Alt+1-5` | Switch desktop |
| `Alt+Shift+1-5` | Send window to desktop |
| `Print` | Full screenshot |
| `Shift+Print` | Area screenshot |

## Quick Commands

```bash
just rebuild       # rebuild my-vm + gc + optimise
just rebuild-x11   # rebuild my-vm-x11 + gc + optimise
just update        # git pull + rebuild + gc + optimise + reboot
just update-x11    # same for x11 host
just upgrade       # nix flake update + rebuild + gc + optimise + reboot
just upgrade-x11   # same for x11 host
just clean         # keep last N generations + vacuum journal
just clean-all     # full cleanup (all generations, journal, tmp)
```

## Secrets

Managed with sops-nix + age. First-time setup:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
sops secrets/secrets.yaml
```

Secrets stored in `/run/secrets/`:
- `deepseek_api_key` — DeepSeek API key (pi, Zed agent)
- `brave_search_api_key` — Brave Search API key (Zed MCP)

## Structure

```
├── flake.nix                    ← Flake entry: inputs, outputs, hosts
├── Justfile                     ← Quick commands (rebuild, update, upgrade)
├── .gitignore
├── .sops.yaml                   ← SOPS config
├── images/
│   └── desktop-screenshot.png
├── system/                      ← NixOS-level (shared by all hosts)
│   ├── common.nix               ← nix-ld, flakes, GC, autoUpgrade
│   ├── host-base.nix            ← Shared host base (boot, network, users, tz)
│   ├── disk-config.nix          ← Shared disk partitioning (disko)
│   ├── packages.nix             ← System packages (gcc, git, sops, ...)
│   ├── environment.nix          ← Session vars, fonts
│   ├── programs/
│   │   ├── stylix.nix           ← Theme: Catppuccin Mocha, Banana cursor
│   │   └── xdg-portal.nix       ← XDG Desktop Portal (GTK)
│   ├── services/
│   │   ├── sops.nix             ← Secrets management
│   │   └── ssh.nix              ← OpenSSH server
│   └── wallpapers/
│       └── default.jpg
├── desktop/
│   ├── wayland/                 ← Wayland desktop (Niri + Noctalia)
│   │   ├── home.nix             ← Home-manager module imports
│   │   ├── system.nix           ← NixOS config (greetd, portal, env vars)
│   │   ├── niri.nix             ← Niri WM: layout, binds, rules, spawn
│   │   ├── noctaliashell.nix    ← Noctalia bar, dock, wallpaper
│   │   └── packages.nix         ← Wayland-specific packages
│   └── x11/                     ← X11 desktop (BSPWM)
│       ├── home.nix             ← Home-manager module imports
│       ├── system.nix           ← NixOS config (LightDM, X server)
│       ├── bspwm-config.nix     ← BSPWM config + systemd services
│       ├── sxhkdrc              ← sxhkd keybindings
│       └── packages.nix         ← X11-specific packages
├── home/                        ← User-level (home-manager)
│   ├── packages.nix             ← User packages (dust, glow, zig, ...)
│   └── programs/
│       ├── astronvim/           ← Neovim + AstroNvim
│       │   ├── default.nix
│       │   └── lua/
│       │       ├── community.lua
│       │       ├── options.lua
│       │       └── plugins/
│       │           ├── neo-tree.lua, nightfox.lua, yazi.lua
│       │           ├── glow.lua, crystal.lua, mint.lua
│       ├── pi/                  ← AI coding agent
│       │   ├── default.nix      ← pi wrapper + agent config files
│       │   └── agent/
│       │       ├── models.nix   ← DeepSeek models config
│       │       ├── settings.nix ← Agent defaults
│       │       ├── themes/
│       │       ├── skills/      ← nix-style, web-search, caveman, design-systems
│       │       └── extensions/  ← caveman, ds-balance
│       ├── zed-editor/          ← Zed IDE
│       │   ├── default.nix      ← Settings + wrapper with API key
│       │   └── AGENTS.md
│       ├── fastfetch/           ← System info display
│       │   ├── default.nix      ← Custom doge logo + modules
│       │   └── doge.nix         ← ASCII art logo
│       ├── atuin.nix, bat.nix, bottom.nix, brave.nix, delta.nix,
│       ├── eza.nix, fd.nix, ghostty.nix, git.nix, lazygit.nix,
│       ├── liger.nix, ripgrep.nix, starship.nix, yazi.nix,
│       ├── zoxide.nix, zsh.nix
│       └── ...
└── hosts/
    ├── my-vm/                   ← Wayland host
    │   ├── configuration.nix    ← Imports host-base, sets hostname
    │   ├── home.nix             ← User config + program imports
    │   └── disk-config.nix      ← Imports shared disk layout
    └── my-vm-x11/               ← X11 host
        ├── configuration.nix    ← Imports host-base + X11 config
        ├── home.nix             ← Same programs as my-vm
        └── disk-config.nix      ← Imports shared disk layout
```

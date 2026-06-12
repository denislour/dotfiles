# NixOS dotfiles

X11 stack: **N**ixOS + **C**hadwm + **A**lacritty on VMware Workstation 17 Pro
Also available: Wayland stack (Niri + Noctalia) for 3D-accelerated VMs.

![Desktop screenshot](images/desktop-screenshot.png)

## Hosts

| Host | Desktop | WM | Status |
|------|---------|----|--------|
| `my-vm-x11` | X11 | Chadwm (DWM fork) | **Primary** — lightweight, stable |
| `my-vm` | Wayland | Niri + Noctalia | Secondary — needs 3D acceleration |

---

# X11 — Chadwm (Primary)

## Why X11

- VMware Workstation 17 Pro has limited 3D support → Wayland lags
- X11 + Chadwm lightweight (great for 4 CPU / 8 GB VM)
- Chadwm bar with status2d + system info script
- Sxhkd for consistent keybindings

## VM Settings

| Setting | Value |
|---------|-------|
| 3D Acceleration | **OFF** |
| CPUs | 4 |
| RAM | 8 GB |
| Disk | 40 GB |

## Quick Commands

```bash
just rebuild-x11        # build my-vm-x11 + gc + optimise
just rebuild-x11-lite   # build my-vm-x11 (fast, no cleanup)
just update-x11         # pull + build + cleanup + reboot
just upgrade-x11        # flake update + build + cleanup + reboot
```

## Keybinds (X11 — Chadwm)

| Key | Action |
|-----|--------|
| `Alt+Return` | Terminal (alacritty) |
| `Alt+Space` | Rofi app launcher |
| `Alt+q` | Close window |
| `Alt+f` | Fullscreen |
| `Alt+j/k` | Focus next/previous |
| `Alt+h/l` | Resize master |
| `Alt+1-5` | Switch tag |
| `Alt+Shift+1-5` | Move window to tag |
| `Alt+Space` | Cycle layouts |
| `Alt+Shift+q` | Lock screen (i3lock) |
| `Alt+s` | Screenshot full |
| `Alt+Shift+s` | Screenshot area |
| `Print` | Screenshot |
| `Alt+b` | Toggle bar |
| `Alt+Shift+r` | Restart dwm |
| `XF86Audio*` | Volume, media keys |

## Theme — Stylix (Catppuccin Mocha)

All components automatically themed:
- Chadwm bar (CPU%, MEM, clock with status2d colors)
- Rofi (style-5, centered, Catppuccin Powerline)
- Alacritty
- Starship prompt
- GTK/Qt apps
- Firefox / LibreWolf
- Zellij
- Yazi

## Wallpaper

From [gh0stzk/dotfiles](https://github.com/gh0stzk/dotfiles) — Emilia rice. Available in `system/wallpapers/`.

## Software Stack

| Category | Choice |
|----------|--------|
| Window Manager | Chadwm (DWM fork with gaps, themes, status2d) |
| Display Manager | LightDM (auto-login enabled) |
| Terminal | Alacritty (JetBrainsMono Nerd Font) |
| Launcher | Rofi (style-5 centered) |
| Shell | Zsh + Starship (Catppuccin Powerline) |
| Multiplexer | Zellij (no bars, clean) |
| Editor | Neovim + AstroNvim |
| AI Coding | Pi agent (DeepSeek) |
| Browser | Brave / LibreWolf |
| File Manager | Yazi + feh for images |
| Music | MPD + ncmpcpp |
| Notifications | Dunst |
| Compositor | Picom (xrender backend for VMware) |
| Secrets | SOPS + age |

---

# Wayland — Niri + Noctalia (Secondary)

## VM Settings

| Setting | Value |
|---------|-------|
| 3D Acceleration | **ON** |
| CPUs | 4 |
| RAM | 8 GB |
| Disk | 40 GB |

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
| `XF86Audio*` | Volume, media keys |

---

## Common Software

| Tool | Replaces | Why |
|------|----------|------|
| `eza` | `ls` | Colors, icons, git status |
| `bat` | `cat` | Syntax highlighting |
| `fd` | `find` | Faster, intuitive |
| `rg` | `grep` | Fast code search |
| `delta` | `diff` | Side-by-side diffs |
| `btm` | `top` | TUI with charts |
| `dust` | `du` | Visual disk usage |
| `procs` | `ps` | Human-readable processes |
| `atuin` | `history` | Ctrl+R fuzzy search |
| `starship` | prompt | Minimal, fast |
| `zoxide` | `cd` | Smart directory jumping |
| `lazygit` | `git` | TUI git client |
| `glow` | markdown | Terminal markdown renderer |

## Structure

```
├── flake.nix              ← Inputs, overlays, sharedModules, hosts
├── Justfile               ← rebuild/update shortcuts
├── system/                ← NixOS-level (shared by all hosts)
│   ├── host-base.nix      ← Boot, network, users, timezone
│   ├── common.nix         ← nix-ld, flakes, GC, updates
│   ├── disk-config.nix    ← Disko partitioning
│   ├── packages.nix       ← System packages
│   ├── programs/stylix.nix← Catppuccin Mocha theming
│   ├── services/          ← sops, ssh
│   └── wallpapers/        ← default.jpg, emilia-01.webp
├── desktop/
│   ├── x11/               ← X11 desktop (Chadwm)
│   │   ├── chadwm.nix     ← WM + sxhkd + picom/dunst/bar
│   │   ├── system.nix     ← LightDM, X session
│   │   ├── packages.nix   ← X11 utilities
│   │   └── home.nix       ← Module imports
│   └── wayland/           ← Wayland (Niri + Noctalia)
├── hosts/
│   ├── my-vm-x11/         ← Primary X11 host
│   └── my-vm/             ← Wayland host
└── home/                  ← User-level (home-manager)
    ├── packages.nix       ← User packages
    └── programs/          ← One file per program
```

## Secrets

Managed with sops-nix. First-time setup:

```bash
age-keygen -o ~/.config/sops/age/keys.txt
sops secrets/secrets.yaml
```

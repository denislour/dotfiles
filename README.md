# NixOS dotfiles — X11

X11 stack: **N**ixOS + **C**hadwm + **A**lacritty on VMware Workstation 17 Pro

![Desktop screenshot](images/desktop-screenshot.png)

## Host

| Host        | Desktop | WM                | Status                            |
| ----------- | ------- | ----------------- | --------------------------------- |
| `my-vm-x11` | X11     | Chadwm (DWM fork) | **Primary** — lightweight, stable |

---

# X11 — Chadwm (Primary)

## Why X11

- VMware Workstation 17 Pro has limited 3D support → Wayland lags
- X11 + Chadwm lightweight (great for 4 CPU / 8 GB VM)
- Chadwm bar with status2d + system info script
- Sxhkd for consistent keybindings

## VM Settings

| Setting         | Value   |
| --------------- | ------- |
| 3D Acceleration | **OFF** |
| CPUs            | 4       |
| RAM             | 8 GB    |
| Disk            | 40 GB   |

## Quick Commands

```bash
just rebuild-x11        # build + gc + optimise
just rebuild-x11-lite   # build (fast, no cleanup)
just update-x11         # pull + build + cleanup + reboot
just upgrade-x11        # flake update + build + cleanup + reboot
just clean              # delete old gens + gc + optimise
```

## Keybinds (X11 — Chadwm)

| Key             | Action               |
| --------------- | -------------------- |
| `Alt+Return`    | Terminal (alacritty) |
| `Alt+Space`     | Rofi app launcher    |
| `Alt+q`         | Close window         |
| `Alt+f`         | Fullscreen           |
| `Alt+j/k`       | Focus next/previous  |
| `Alt+h/l`       | Resize master        |
| `Alt+1-5`       | Switch tag           |
| `Alt+Shift+1-5` | Move window to tag   |
| `Alt+Space`     | Cycle layouts        |
| `Alt+Shift+q`   | Lock screen (slock)  |
| `Alt+s`         | Screenshot full      |
| `Alt+Shift+s`   | Screenshot area      |
| `Print`         | Screenshot           |
| `Alt+b`         | Toggle bar           |
| `Alt+Shift+r`   | Restart dwm          |
| `XF86Audio*`    | Volume, media keys   |

## Theme — Stylix (Catppuccin Mocha)

All components automatically themed:

- Chadwm bar (CPU%, MEM, clock, disk with status2d colors)
- Rofi (style-5, centered, Papirus icons)
- Alacritty
- Starship prompt
- GTK/Qt apps
- Firefox / LibreWolf
- Zellij
- Yazi

## Wallpaper

Qiuyuan / Emilia — available in `system/wallpapers/`.

## Software Stack

| Category        | Choice                                        |
| --------------- | --------------------------------------------- |
| Window Manager  | Chadwm (DWM fork with gaps, themes, status2d) |
| Display Manager | LightDM (auto-login enabled)                  |
| Terminal        | Alacritty → Zellij (JetBrainsMono Nerd Font)  |
| Launcher        | Rofi (style-5 centered)                       |
| Shell           | Zsh + Starship + Atuin                        |
| Multiplexer     | Zellij (no bars, clean)                       |
| Editor          | Neovim + AstroNvim / Zed                      |
| AI Coding       | Pi agent (DeepSeek) + Zed agent               |
| Browser         | LibreWolf / Brave                             |
| File Manager    | Yazi + feh for images                         |
| Music           | MPD + ncmpcpp                                 |
| Notifications   | Dunst                                         |
| Compositor      | Picom (xrender backend for VMware)            |
| Secrets         | SOPS + age                                    |

## Structure

```
├── flake.nix              ← Inputs, overlays, sharedModules, hosts
├── Justfile               ← rebuild/update shortcuts
├── system/                ← NixOS-level (shared by all hosts)
│   ├── host-base.nix      ← Boot, network, users, timezone
│   ├── common.nix         ← nix-ld, flakes, GC, optimise
│   ├── disk-config.nix    ← Disko partitioning
│   ├── packages.nix       ← System packages
│   ├── programs/stylix.nix← Catppuccin Mocha theming
│   ├── services/          ← sops, ssh
│   └── wallpapers/        ← default.jpg, emilia-01.webp
├── desktop/
│   ├── x11/               ← X11 desktop (Chadwm)
│   │   ├── chadwm.nix     ← WM + bar script + autostart
│   │   ├── system.nix     ← X session config
│   │   ├── packages.nix   ← X11 utilities
│   │   ├── picom.nix      ← Compositor
│   │   ├── dunst.nix      ← Notifications
│   │   ├── sxhkd.nix      ← Hotkey daemon
│   │   └── home.nix       ← Module imports
│   └── wayland/           ← Wayland (Niri + Noctalia) — archived
├── hosts/
│   ├── my-vm-x11/         ← Primary X11 host
│   └── my-vm/             ← Wayland host — archived
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

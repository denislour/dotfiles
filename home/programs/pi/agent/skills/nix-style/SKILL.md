---
name: nix-style
description: >
  Strict Nix code style and conventions for this project.
  Used when editing any Nix file to guarantee consistency.
  No comments in code — code must be self-documenting.
  Exception: comments for disabled zed-editor imports in hosts/*/home.nix.
---

# Nix Style Guide

Code must be self-documenting. No inline comments, no block comments.
If something needs explanation, make the code clearer instead.
Extension docstrings (JSDoc `/** ... */`) are the only exception in .ts files.

## General Rules

- **No comments** in `.nix` files, `.ts` files (except JSDoc), `.lua` files, or any config
- **Exception:** `# ../../home/programs/zed-editor  # enable when needed` in `hosts/*/home.nix`
- **No blank lines** between related settings. Blank line only between logical sections
- **Clean and minimal** — no unused imports, dead code, or `with` that shadows
- Use `lib.mkForce` / `lib.mkDefault` appropriately. Never override without reason
- `with pkgs;` only inside package lists: `home.packages = with pkgs; [ pkg ];`

## Function Argument Styles (by file type)

| File Type | Pattern | Example |
|-----------|---------|---------|
| Program with no deps | `{\n  programs.xx = {` | `atuin.nix`, `bat.nix` |
| Program needs pkgs | `{ pkgs, ... }: {` | `brave.nix`, `packages.nix` |
| System module (NixOS) | `{ ... }:\n\n{` | `common.nix`, `ssh.nix` |
| File with let block | `{ ... }:\n\nlet ... in\n{` | `niri.nix`, `fastfetch/default.nix` |
| Multi-dep file | `{ pkgs, lib, config, ... }: ... let ... in` | `astronvim/default.nix`, `pi/default.nix` |
| Host configuration | `{ ... }: { imports = [ ... ];` | `hosts/*/configuration.nix` |

## Formatting

- 2-space indentation throughout
- Short attributes on one line: `border = { width = 2; };`
- Multi-line attributes: consistent indent, no extra blank lines inside braces
- Lists: `[ "item1" "item2" ]` — space after `[`, space before `]`
- Attribute sets: `{ key = value; }` — trailing semicolon
- `let` block always on its own line after blank line: `{ ... }:\n\nlet ... in\n{`
- No blank line between `in` and `{` in let blocks: `in\n{`

## Naming

| Scope | Convention | Example |
|-------|-----------|---------|
| NixOS options | `camelCase` | `autoOptimiseStore` |
| Variables | `camelCase` | `myVar` |
| File names | `kebab-case` | `home-manager.nix` |
| Attribute names | `camelCase` | `myService` |
| Quotes | Only for special chars (dots, hyphens) | `"my-module"` |

## Module Structure

### NixOS module
```nix
{ config, lib, pkgs, ... }: {
  imports = [ ... ];
  options = ...;
  config = ...;
}
```

### Home-manager module (no deps)
```nix
{
  programs.xx.enable = true;
}
```

### Home-manager module (with pkgs)
```nix
{ pkgs, ... }: {
  programs.xx.enable = true;
  home.packages = with pkgs; [ package ];
}
```

### Flake output
```nix
{
  description = "description";
  inputs = { ... };
  outputs = { self, nixpkgs, ... } @ inputs: let ... in { ... };
}
```

## Project Layout

| Path | Purpose |
|------|---------|
| `flake.nix` | Flake entry — inputs, outputs, sharedModules, nixosConfigurations |
| `system/*.nix` | NixOS-level config (common, packages, environment) |
| `system/host-base.nix` | Shared base for all hosts (boot, network, users, timezone) |
| `system/disk-config.nix` | Shared disk partitioning layout |
| `system/programs/` | NixOS-level program config (stylix, xdg-portal) |
| `system/services/` | NixOS-level service config (sops, ssh) |
| `hosts/<name>/` | Per-machine config (configuration.nix, home.nix, disk-config.nix) |
| `desktop/<wm>/` | Desktop environment (wayland/niri, x11/bspwm) |
| `home/packages.nix` | Home-manager user-level packages |
| `home/programs/<name>.nix` | One file per program |
| `home/programs/<name>/default.nix` | One dir per program (when multiple files needed) |
| `home/programs/pi/agent/` | Pi AI agent config |

## Host Config Pattern

Host configs import shared base and only define unique values:

```nix
# hosts/<name>/configuration.nix
{ ... }: {
  imports = [ ../../system/host-base.nix ];
  networking.hostName = "unique-hostname";
}
```

Disk configs import shared layout:

```nix
# hosts/<name>/disk-config.nix
import ../../system/disk-config.nix
```

## Project Conventions

- Neovim → user-level via home-manager (`programs.neovim`), not in system packages
- Stylix handles all theming (GTK, Qt). No manual color config
- `environment.systemPackages` for system tools only. User tools via home-manager
- Secrets via SOPS. Referenced as `/run/secrets/<name>`
- `config.home.homeDirectory` for home paths (DRY, use `let homeDir = ...` once)
- Desktop envs separated by desktop/wayland vs desktop/x11
- Browser: Brave (not LibreWolf — README outdated if says otherwise)

## Git Commits

One line, conventional commits. No body, no footers.

```
feat: add rust-analyzer to astronvim LSPs
fix: resolve qt.platformTheme conflict with Stylix
style: remove all comments for clean code
refactor: extract niri layout to separate file
chore: update flake.lock
docs: add pi-extensions skill for writing extensions
```

Rules:
- **One concern per commit.** Never mix feat + fix + style
- **Under 72 chars.** Single line only
- **Scope optional:** `feat(niri):`, `fix(pi):` — match area of change
- Check `git log --oneline -20` before writing. Match tone of recent commits

## Research Before Implementing

1. Use `web-search` skill for current best practices (NixOS Discourse, GitHub, NixOS Wiki)
2. Check nixpkgs for latest version — avoid hardcoding outdated names
3. Prefer built-in NixOS options over manual hacks. Search `search.nixos.org` first
4. If package exists in nixpkgs, use `pkgs.<name>`. No `fetchTarball` or `fetchFromGitHub` for packages already in nixpkgs
5. Pin `rev` + `sha256` only for repos not in nixpkgs (e.g., AstroNvim template, custom builds)

## Anti-patterns

1. **No `with lib;`** — use `inherit (lib) mkForce;` instead
2. **No deeply nested `let in`** — flat, one `let ... in` per file
3. **No `rec { }`** — explicit references only
4. **No `import ./path` mid-file** — use `imports = [ ... ]` at top (exception: disk-config.nix import-only files)
5. **No `builtins.pathExists`** — shell checks in activation scripts
6. **No broad `with pkgs;`** — `with pkgs; [ package ]` inside package lists only
7. **No inline comments** — really, none. Exception: zed-editor in hosts/*/home.nix
8. **No unused function args** — if you declare `lib` in args, you must use it
9. **No hardcoded `/home/username`** — use `config.home.homeDirectory`
10. **No diskoConfigurations in flake output** — disk configs loaded via NixOS modules only

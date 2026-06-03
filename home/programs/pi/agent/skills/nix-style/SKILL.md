---
name: nix-style
description: >
  Nix code style and conventions for this project.
  Use when editing Nix files to ensure consistency.
  No comments in code — code must be self-documenting.
  Exception: JSDoc docstrings in TypeScript extensions.
---

# Nix Style Guide

Code must be self-documenting. No inline comments, no block comments. If something needs explanation, make the code clearer instead. Extension docstrings (JSDoc `/** ... */`) are the only exception.

## General Rules

- **No comments** in `.nix` files, `.ts` files (except JSDoc), `.lua` files, or any config
- **No blank lines** between related settings. Blank line only between logical sections
- **Clean and minimal** — no unused imports, dead code, or `with` that shadows
- Extension files: JSDoc header describing usage is fine. No inline `//` comments
- Use `lib.mkForce` / `lib.mkDefault` appropriately. Never override without reason

## Formatting

- 2-space indentation
- Short attributes on one line: `border = { width = 2; };`
- Multi-line attributes: consistent indent, no extra blank lines inside braces
- Lists: `[ "item1" "item2" ]` — space after `[`, space before `]`
- Attribute sets: `{ key = value; }` — trailing semicolon

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

### Home-manager module
```nix
{ pkgs, lib, config, ... }: {
  programs.neovim.enable = true;
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
| `system/*.nix` | NixOS-level config |
| `hosts/<name>/` | Per-machine config |
| `home/*.nix` | Home-manager modules |
| `home/programs/<name>/default.nix` | One dir per program |
| `home/programs/pi/agent/extensions/<name>/index.ts` | Pi extensions |
| `home/programs/pi/agent/skills/<name>/SKILL.md` | Pi skills |
| `secrets/` | SOPS-managed secrets |
| `/run/secrets/` | Runtime secret paths |

## Project Conventions

- Neovim → user-level via home-manager (`programs.neovim`), not in system packages
- Stylix handles all theming (GTK, Qt). No manual color config
- `environment.systemPackages` for system tools only. User tools via home-manager
- Secrets via SOPS. Referenced as `/run/secrets/<name>` in wrappers

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
4. **No `import ./path` mid-file** — use `imports = [ ... ]` at top
5. **No `builtins.pathExists`** — shell checks in activation scripts
6. **No broad `with pkgs;`** — scope tightly: `with pkgs; [ package ]` inside package lists only
7. **No inline comments** — really, none. JSDoc in extensions only

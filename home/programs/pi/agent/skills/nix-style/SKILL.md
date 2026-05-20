---
name: nix-style
description: Nix code style and conventions for this project. Use when editing Nix files to ensure consistency.
---

# Nix Style Guide

This project follows a strict, clean, minimal Nix style. Apply these rules when writing or editing any `.nix` files.

## General Rules

- **No comments.** Code must be self-documenting. Remove all inline comments (`#`) and block comments (`/* */`). If something needs explanation, make the code clearer instead.
- **No blank lines** between closely related settings. Use blank lines only to separate logical sections.
- **Clean and minimal.** No unused imports, no dead code, no `with` statements that shadow.
- **Follow Nixpkgs conventions.** Use `lib.mkForce` and `lib.mkDefault` appropriately, never override without reason.

## Formatting

- Use 2-space indentation.
- Attributes on one line when short: `border = { width = 2; };`
- Multi-line attributes use consistent indentation with no extra blank lines inside braces.
- Lists: `[ "item1" "item2" ]` with space after opening bracket.
- Attribute sets: `{ key = value; }` with trailing semicolon.

## Naming

- `camelCase` for NixOS option names and attribute names.
- `kebab-case` for file names only.
- Quotes only when identifier contains special characters (dots, hyphens).

## Module Structure

### NixOS modules
```nix
{ config, lib, pkgs, ... }: {
  imports = [ ... ];
  options = ...;
  config = ...;
}
```

### Home-manager modules
```nix
{ pkgs, lib, config, ... }: {
  programs.neovim.enable = true;
  home.packages = with pkgs; [ package ];
}
```

### Flake outputs
```nix
{
  description = "description";
  inputs = { ... };
  outputs = { self, nixpkgs, ... } @ inputs: let ... in { ... };
}
```

## Project Conventions

- System config: `system/*.nix` — NixOS-level configuration.
- Host config: `hosts/<name>/` — per-machine config.
- User config: `home/*.nix` — home-manager modules.
- Programs: `home/programs/<name>/default.nix` — one directory per program.
- Secrets: managed via SOPS (`secrets/`), referenced via `/run/secrets/`.
- No `programs.neovim` in system packages — neovim is user-level via home-manager.
- Stylix handles all theming (GTK, Qt). Do not set colors manually.
- No `environment.systemPackages` for user tools — use home-manager instead.

## Anti-patterns to avoid

1. **No `with lib;`** — import explicitly: `inherit (lib) mkForce;`
2. **No deeply nested `let in`** — keep it flat, use `let ... in` once per file.
3. **No `rec { }`** — prefer explicit references.
4. **No `import ./path` in the middle of files** — use `imports = [ ... ]` at top.
5. **No `builtins.pathExists`** — use shell checks in activation scripts instead.
6. **No broad `with pkgs;`** — scope it tightly: `with pkgs; [ package ]` only inside package lists.
7. **No comments** — really, none.

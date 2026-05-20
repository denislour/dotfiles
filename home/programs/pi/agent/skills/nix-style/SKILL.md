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

## Git Commit Convention

Follow **Conventional Commits** with one line per commit (no multi-line bodies):

```
feat: add rust-analyzer to astronvim LSPs
fix: resolve qt.platformTheme conflict with Stylix
style: remove all comments for clean code
refactor: extract niri layout to separate file
chore: update flake.lock
docs: add nix-style skill for code generation
```

Rules:
- **One concern = one commit.** Never mix `feat` + `fix` + `style` in the same commit.
- **One line only.** Subject line under 72 chars. No body, no footers.
- **Use `git log --oneline`** before writing a commit. Reference past style to stay consistent with existing commit history.
- **Scope** (optional): `feat(niri):`, `fix(stylix):`, `feat(pi):` — match the area of change.
- When in doubt, run `git log --oneline -20` and match the tone of recent commits.

## Research Before Implementing

When adding new packages, fixing issues, or configuring unfamiliar tools:

1. **Use the `web-search` skill** to find current best practices (NixOS Discourse, GitHub issues, r/NixOS, NixOS Wiki).
2. **Check nixpkgs for latest version** — avoid hardcoding outdated package names or deprecated options.
3. **Prefer NixOS/nixpkgs built-in options** over manual hacks. Search `search.nixos.org` first.
4. If a package exists in nixpkgs, use `pkgs.<name>` — do not fetch from GitHub or use `builtins.fetchTarball`.
5. Pin `rev` + `sha256` only for repos not in nixpkgs (e.g., AstroNvim template).

## Anti-patterns to avoid

1. **No `with lib;`** — import explicitly: `inherit (lib) mkForce;`
2. **No deeply nested `let in`** — keep it flat, use `let ... in` once per file.
3. **No `rec { }`** — prefer explicit references.
4. **No `import ./path` in the middle of files** — use `imports = [ ... ]` at top.
5. **No `builtins.pathExists`** — use shell checks in activation scripts instead.
6. **No broad `with pkgs;`** — scope it tightly: `with pkgs; [ package ]` only inside package lists.
7. **No comments** — really, none.

{ pkgs, ... }:

with pkgs; [
  cliphist
  dust
  glow
  just
  procs
  sd
  trunk
  wl-clipboard
  wl-clip-persist
  wl-gammarelay-rs

  # seekr / cloudflare worker dev
  wrangler
  worker-build
  sqlite
]

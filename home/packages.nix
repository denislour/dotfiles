{ pkgs, inputs, ... }:

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
  wlsunset
  inputs.zen-browser.packages.${pkgs.system}.default
]

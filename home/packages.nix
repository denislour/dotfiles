{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    cliphist
    dust
    glow
    just
    procs
    sd
    trunk
    zig
    grim
    slurp
    wl-clipboard
    wl-clip-persist
    wl-gammarelay-rs
    wl-gammarelay-applet
    brightnessctl
    xorg.xrandr
    wrangler
    worker-build
    sqlite
  ];
}

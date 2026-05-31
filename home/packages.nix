{ pkgs, ... }: {
  home.packages = with pkgs; [
    cliphist
    dust
    glow
    just
    kdePackages.falkon
    procs
    sd
    trunk
    zig
    grim
    slurp
    wl-clipboard
    wl-clip-persist
    wl-gammarelay-rs
    wrangler
    worker-build
    sqlite
  ];
}

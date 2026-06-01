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
    crystal
    mint
    ameba
    grim
    slurp
    wl-clipboard
    wl-clip-persist
    xrandr
    wrangler
    worker-build
    sqlite
  ];
}

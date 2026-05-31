{ pkgs, ... }: {
  home.packages = with pkgs; [
    cliphist
    dust
    glow
    just
    procs
    qutebrowser
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

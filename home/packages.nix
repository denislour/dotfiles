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
    wrangler
    worker-build
    sqlite
    ungoogled-chromium
  ];
}

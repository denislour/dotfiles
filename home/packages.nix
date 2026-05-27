{ pkgs, ... }: {
  home.packages = with pkgs; [
    cliphist
    dust
    epiphany
    gitui
    glow
    just
    procs
    sd
    tig
    trunk
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

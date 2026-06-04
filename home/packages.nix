{ pkgs, ... }: {
  home.packages = with pkgs; [
    dust
    glow
    just
    procs
    sd
    trunk
    zig
    crystal
    shards
    mint
    ameba
    xrandr
    wrangler
    worker-build
    sqlite
    sqlite.dev
  ];
}

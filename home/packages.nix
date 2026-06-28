{ pkgs, ... }: {
  home.packages = with pkgs; [
    dust
    glow
    just
    procs
    sd
    trunk
    crystal
    shards
    mint
    ameba
    xrandr
    wrangler
    worker-build
    sqlite
    sqlite.dev
    playerctl
    mpd
    mpc
    ncmpcpp
    yt-dlp
    go
    nodejs
    rainfrog
    uv
  ];
}

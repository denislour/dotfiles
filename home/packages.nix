{
  pkgs,
  config,
  lib,
  ...
}: let
  vscodeWithFlags = pkgs.symlinkJoin {
    name = "vscode-with-flags";
    paths = [pkgs.vscode];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      rm -f $out/bin/code
      makeWrapper ${pkgs.vscode}/bin/code $out/bin/code \
        --add-flags "--disable-gpu"
    '';
  };
in {
  home.packages = with pkgs; [
    dust
    glow
    just
    procs
    sd
    vscodeWithFlags
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
    postgresql
    rainfrog
    uv
  ];
}

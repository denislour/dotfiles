{
  pkgs,
  config,
  lib,
  ...
}: let
  vscodeWithFlags = pkgs.symlinkJoin {
    name = "vscode-with-flags";
    paths = [pkgs.vscodium];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      rm -f $out/bin/codium $out/bin/code
      makeWrapper ${pkgs.vscodium}/bin/codium $out/bin/codium \
        --add-flags "--disable-gpu"
      ln -s $out/bin/codium $out/bin/code
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

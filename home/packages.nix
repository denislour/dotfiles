{ pkgs, lib, ... }:

let
  falkonLight = pkgs.writeShellScriptBin "falkon" ''
    export QT_STYLE_OVERRIDE=fusion
    exec ${lib.getExe pkgs.kdePackages.falkon} "$@"
  '';
in {
  home.packages = with pkgs; [
    falkonLight
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
  ];
}

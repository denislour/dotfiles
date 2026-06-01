{ pkgs, lib, ... }:
let
  liger = pkgs.stdenv.mkDerivation {
    pname = "liger";
    version = "0.1.3";
    src = pkgs.fetchFromGitHub {
      owner = "navid-m";
      repo = "liger";
      rev = "v0.1.2";
      sha256 = "sha256-yyiZU9e8qIqO83QrThhKxR08sBYqyxGTGBCTLu+KWi4=";
    };
    buildInputs = [ pkgs.crystal ];
    buildPhase = ''
      crystal build src/liger.cr --release -o liger
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp liger $out/bin/
    '';
  };
in {
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
    liger
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

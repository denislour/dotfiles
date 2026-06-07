{ pkgs, lib, ... }:

let
  polycat = pkgs.stdenv.mkDerivation {
    pname = "polycat";
    version = "2.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "zzimt";
      repo = "polycat";
      rev = "v2.0.0";
      hash = "sha256-wpDx6hmZe/dLv+F+kbo+YUIZ2A8XgnrZP0amkz6I5IQ=";
    };

    makeFlags = [ "POLYCAT_RELEASE=1" "PREFIX=$(out)" ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/share/fonts/TTF $out/share/polycat
      install -Dm755 build/polycat $out/bin/polycat
      install -Dm644 res/polycat.ttf $out/share/fonts/TTF/polycat.ttf
      install -Dm644 res/polycat-config $out/share/polycat/polycat-config
      runHook postInstall
    '';
  };
in {
  home.packages = with pkgs; [ polycat ];

  xdg.configFile."polycat/polycat-config".source = "${polycat}/share/polycat/polycat-config";
}

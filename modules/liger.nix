{ inputs, ... }:

let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.modules.homeManager.liger = { pkgs, ... }: {
    home.packages = with pkgs; [
      (pkgs.stdenv.mkDerivation {
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
        meta.mainProgram = "liger";
      })
    ];
  };
}

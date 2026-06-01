{ lib, stdenv, fetchFromGitHub, crystal }:

stdenv.mkDerivation {
  pname = "liger";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "navid-m";
    repo = "liger";
    rev = "v0.1.2";
    sha256 = "sha256-yyiZU9e8qIqO83QrThhKxR08sBYqyxGTGBCTLu+KWi4=";
  };

  buildInputs = [ crystal ];

  buildPhase = ''
    crystal build src/liger.cr --release -o liger
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp liger $out/bin/
  '';

  meta.mainProgram = "liger";
}

{ inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    ./niri.nix
    ./noctaliashell.nix
  ];
}

{ inputs, ... }: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.noctalia.homeModules.default
    ./niri.nix
    ./noctaliashell.nix
    ./packages.nix
  ];
}

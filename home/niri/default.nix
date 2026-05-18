{ inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./noctaliashell.nix
    ./rules.nix
  ];
}

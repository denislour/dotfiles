{ lib, ... }:

{
  programs.nix-ld.enable = true;
  qt.enable = lib.mkForce false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    min-free = 5120;
    max-free = 10240;
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  nix.optimise.automatic = true;
}

{ lib, pkgs, ... }:

{
  programs.nix-ld.enable = true;

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

  # Daily fstrim to reclaim VM disk space after nix-collect-garbage
  services.fstrim = {
    enable = true;
    interval = "daily";
  };
}

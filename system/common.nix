{...}: {
  programs.nix-ld.enable = true;
  qt.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    min-free = 5120;
    max-free = 10240;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  nix.optimise.automatic = true;
}

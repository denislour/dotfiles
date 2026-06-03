{ ... }: {
  flake.modules.homeManager.brave = { pkgs, ... }: {
    programs.brave = {
      enable = true;
      commandLineArgs = [
        "--force-dark-mode"
        "--enable-features=WebContentsForceDark:inversion_method/cielab_based/image_behavior/none"
        "--ozone-platform-hint=auto"
        "--force-device-scale-factor=1.25"
      ];
    };
  };
}

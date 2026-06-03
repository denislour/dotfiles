{ ... }: {
  flake.modules.nixos.base = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    time.timeZone = "Asia/Ho_Chi_Minh";
    i18n.defaultLocale = "en_US.UTF-8";

    security.sudo.wheelNeedsPassword = false;

    programs.zsh.enable = true;
    hardware.graphics.enable = true;

    services.speechd.enable = false;

    environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

    users.users.jake = {
      isNormalUser = true;
      group = "jake";
      extraGroups = [ "wheel" "networkmanager" "video" "input" ];
      initialPassword = "changeme";
      shell = pkgs.zsh;
    };

    users.groups.jake = { };
  };
}

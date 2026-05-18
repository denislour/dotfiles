{ config, pkgs, lib, wallpaper, ... }: {
  networking.hostName = "my-vm";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.efi.efiSysMountPoint = "/boot";

  users.users.jake = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    initialPassword = "changeme";
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  hardware.graphics.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  virtualisation.vmware.guest.enable = true;

  stylix.image = wallpaper;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
  ];

  system.stateVersion = "25.05";
}

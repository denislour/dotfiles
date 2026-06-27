{ lib, pkgs, wallpaper, ... }:

{
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.efi.efiSysMountPoint = "/boot";

  users.users.jake = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "docker" ];
    initialPassword = "changeme";
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  hardware.graphics.enable = true;

  virtualisation.vmware.guest.enable = true;

  systemd.mounts = [
    {
      where = "/run/vmblock-fuse";
      enable = false;
    }
  ];

  services.speechd.enable = lib.mkForce false;

  stylix.image = wallpaper;

  system.stateVersion = "25.05";
}

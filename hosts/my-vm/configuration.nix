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
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  hardware.graphics.enable = true;

  virtualisation.vmware.guest.enable = true;

  stylix.image = wallpaper;

  services.speechd.enable = false;

  system.stateVersion = "25.05";
}

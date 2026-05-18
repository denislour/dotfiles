{ config, pkgs, lib, ... }: {
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

  hardware.graphics.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  virtualisation.vmware.guest.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    AQ_NO_ATOMIC = "1";
    AQ_NO_MODIFIERS = "1";
  };

  environment.systemPackages = with pkgs; [
    wget curl unzip zip killall
  ];

  system.stateVersion = "25.05";
}

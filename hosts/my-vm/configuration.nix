{ config, pkgs, lib, ... }:

{
  networking.hostName = "my-vm";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.jake = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    initialPassword = "changeme";
  };

  security.sudo.wheelNeedsPassword = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  services.vmware-guest.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    zip
    killall
  ];

  system.stateVersion = "25.05";
}

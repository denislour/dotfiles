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

  hardware.graphics.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  virtualisation.vmware.guest = {
    enable = true;
    # Enable X11 support for clipboard copy-paste (limited on Wayland)
    package = pkgs.open-vm-tools.override { x11Support = true; };
  };

  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.image = wallpaper;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.cursor.size = 24;
  stylix.fonts = {
    monospace = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
    };
    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
    sizes = {
      applications = 10;
      desktop = 10;
      popups = 12;
      terminal = 10;
    };
  };

  # XDG Desktop Portal (needed when home-manager useUserPackages = true)
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

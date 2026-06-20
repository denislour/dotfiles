{ ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "librewolf-151.0.2-1"
  ];
  imports = [ ../../system/host-base.nix ];

  networking.hostName = "my-vm-x11";

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "jake";
  };

}

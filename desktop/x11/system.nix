{ pkgs, lib, ... }:

{
  services.displayManager = {
    ly = {
      enable = true;
      settings = {
        bg = "1e1e2e";
        fg = "cdd6f4";
        asterisk = "◆";
        clear_term = true;
        lang = "us";
        save = false;
        load = true;
        min_refresh_delta = 50;
        xauth_cmd = "${pkgs.xauth}/bin/xauth";
      };
    };
    defaultSession = lib.mkDefault "bspwm";
  };

  environment.etc."ly/setup.sh".source = "${pkgs.ly}/etc/setup.sh";

  services.xserver.desktopManager.session = [{
    name = "bspwm";
    start = ''
      ${pkgs.bash}/bin/bash -c '. /home/jake/.config/bspwm/bspwmrc; exec ${pkgs.bspwm}/bin/bspwm'
    '';
  }];

  services.xserver.videoDrivers = [ "vmware" "modesetting" ];

  xdg.portal.config.common = {
    default = [ "gtk" ];
    "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  };
}

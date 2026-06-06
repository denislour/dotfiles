{ lib, ... }: {
  programs.xfconf.enable = true;

  xfconf.settings = {
    "xfce4-panel" = {
      "/panels/panel-1/position" = "p=6;x=0;y=0";
      "/panels/panel-1/position-locked" = true;
      "/panels/panel-1/length" = 100;
      "/panels/panel-1/size" = 32;
      "/panels/panel-1/autohide-behavior" = 0;

      "/plugins/plugin-1" = "applicationsmenu";
      "/plugins/plugin-2" = "tasklist";
      "/plugins/plugin-3" = "separator";
      "/plugins/plugin-4" = "pager";
      "/plugins/plugin-5" = "separator";
      "/plugins/plugin-6" = "clock";
      "/plugins/plugin-7" = "systray";

      "/panels/panel-1/plugin-ids" = [
        1
        2
        3
        4
        5
        6
        7
      ];
    };

    "xfwm4" = {
      "/general/button_layout" = "|HMC";
      "/general/theme" = "Greybird";
    };

    "xsettings" = {
      "/Net/ThemeName" = "Greybird";
      "/Net/IconThemeName" = "Papirus";
    };
  };
}

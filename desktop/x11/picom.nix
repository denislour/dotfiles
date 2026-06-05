{ pkgs, ... }: {
  home.packages = with pkgs; [ picom ];

  xdg.configFile."picom/picom.conf".text = ''
    backend = "xrender";
    vsync = true;

    fading = true;
    fade-delta = 5;
    fade-in-step = 0.03;
    fade-out-step = 0.03;

    shadow = true;
    shadow-color = "#000000";
    shadow-radius = 12;
    shadow-offset-x = -15;
    shadow-offset-y = -15;
    shadow-opacity = 0.5;

    corner-radius = 6;
    rounded-corners-exclude = [
      "window_type = 'desktop'"
    ];

    blur = {
      method = "none";
    };

    opacity-rule = [
      "0:name *= 'polybar-main'"
    ];

    wintypes = {
      tooltip = { fade = true; shadow = true; opacity = 0.85; };
    };
  '';
}

{ pkgs, ... }: {
  home.packages = with pkgs; [ dunst ];

  xdg.configFile."dunst/dunstrc".text = ''
    [global]
    font = JetBrainsMonoNL Nerd Font 12
    markup = yes
    plain_text = no
    theme = Catppuccin-Mocha

    frame_width = 2
    frame_color = "#cba6f7"
    separator_color = "#313244"
    background = "#1e1e2e"
    foreground = "#cdd6f4"

    width = 350
    height = 100
    offset = 20x20
    origin = top-right

    corner_radius = 10
    padding = 15
    horizontal_padding = 15
    text_icon_alignment = left
    icon_position = left
    min_icon_size = 32
    max_icon_size = 64

    [urgency_low]
    background = "#1e1e2e"
    foreground = "#cdd6f4"
    timeout = 5

    [urgency_normal]
    background = "#1e1e2e"
    foreground = "#cdd6f4"
    timeout = 8

    [urgency_critical]
    background = "#1e1e2e"
    foreground = "#f38ba8"
    timeout = 0
  '';

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

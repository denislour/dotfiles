{ config, pkgs, ... }:

let
  scheme = config.stylix.base16Scheme;
in {
  home.packages = with pkgs; [ dunst ];

  xdg.configFile."dunst/dunstrc".text = ''
    [global]
    font = JetBrainsMonoNL Nerd Font 12
    markup = yes
    plain_text = no

    frame_width = 2
    frame_color = "${scheme.base0E}"
    separator_color = "${scheme.base02}"
    background = "${scheme.base00}"
    foreground = "${scheme.base05}"

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
    background = "${scheme.base00}"
    foreground = "${scheme.base05}"
    timeout = 5

    [urgency_normal]
    background = "${scheme.base00}"
    foreground = "${scheme.base05}"
    timeout = 8

    [urgency_critical]
    background = "${scheme.base00}"
    foreground = "${scheme.base08}"
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

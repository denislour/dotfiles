{ pkgs, ... }: {
  home.packages = with pkgs; [ zellij ];

  xdg.configFile."zellij/config.kdl".text = ''
    theme "catppuccin-mocha"
    plugins {
        tab_bar location="zellij:tab-bar"
        status_bar location="zellij:status-bar"
        strider location="zellij:strider"
        compact_bar location="zellij:compact-bar"
    }
    pane_frames true
    simplified_ui true
    show_startup_tips false
  '';
}

{ pkgs, ... }: {
  home.packages = with pkgs; [ zellij ];

  xdg.configFile."zellij/config.kdl".text = ''
    theme "catppuccin-mocha"
    default_layout "default"
    pane_frames false
    simplified_ui true
    show_startup_tips false

    plugins {
        tab_bar location="zellij:tab-bar"
    }

    keybinds {
        unbind "Ctrl o"
    }
  '';
}

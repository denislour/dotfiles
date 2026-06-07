{ pkgs, ... }: {
  home.packages = with pkgs; [ zellij ];

  xdg.configFile."zellij/config.kdl".text = ''
    theme "catppuccin-mocha"

    plugins {
        tab_bar location="zellij:tab-bar"
        compact_bar location="zellij:compact-bar"
    }
    pane_frames false
    simplified_ui true
    show_startup_tips false

    keybinds {
        unbind "Ctrl + o"
    }
  '';
}

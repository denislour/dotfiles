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
    default_shell "${pkgs.zsh}/bin/zsh"
    scrollback_buffer_size 10000

    keybinds {
        unbind "Ctrl + o"
    }
  '';
}

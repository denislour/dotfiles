{ pkgs, ... }: {
  home.packages = with pkgs; [ zellij ];

  xdg.configFile."zellij/config.kdl".text = ''
    theme "catppuccin-mocha"
    default_layout "nix-layout"
    pane_frames false
    simplified_ui true
    show_startup_tips false

    keybinds {
        unbind "Ctrl o"
    }
  '';

  xdg.configFile."zellij/layouts/nix-layout.kdl".text = ''
    layout {
        pane
    }
  '';
}

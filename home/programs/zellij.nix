{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ zellij ];

  programs.zellij = {
    enable = true;
    settings = {
      theme = "stylix";
      simplified_ui = true;
      show_startup_tips = false;
      pane_frames = false;
      default_shell = "${pkgs.zsh}/bin/zsh";
      default_layout = "compact";
      plugins = {
        tab_bar = "zellij:tab-bar";
        compact_bar = "zellij:compact-bar";
        status_bar = "zellij:status-bar";
      };
      keybinds = {
        unbind = [ "Ctrl o" ];
      };
    };
  };
}

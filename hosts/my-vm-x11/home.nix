{ pkgs, ... }:

{
  home.username = "jake";
  home.homeDirectory = "/home/jake";
  home.stateVersion = "25.05";

  imports = [
    ../../desktop/x11/home.nix
    ../../home/programs/astronvim
    ../../home/programs/atuin.nix
    ../../home/programs/bat.nix
    ../../home/programs/bottom.nix
    ../../home/programs/starship.nix
    ../../home/programs/delta.nix
    ../../home/programs/eza.nix
    ../../home/programs/fastfetch
    ../../home/programs/fd.nix
    ../../home/programs/alacritty.nix
    ../../home/programs/zellij.nix
    ../../home/programs/xfce-panel.nix
    ../../home/programs/git.nix
    ../../home/programs/lazygit.nix
    ../../home/programs/librewolf.nix
    ../../home/programs/pi
    # ../../home/programs/zed-editor  # enable when needed
    ../../home/programs/ripgrep.nix
    ../../home/programs/yazi.nix
    ../../home/programs/zoxide.nix
    ../../home/programs/zsh.nix
    ../../home/packages.nix
    ../../home/programs/liger.nix
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  programs.home-manager.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

  xdg.configFile."mimeapps.list".force = true;
  xdg.dataFile."applications/mimeapps.list".force = true;

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=alacritty
    WebBrowser=librewolf
  '';

  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="xfce4-keyboard-shortcuts" version="1.0">
      <property name="commands" type="empty">
        <property name="custom" type="empty">
          <property name="&lt;Alt&gt;Return" type="string" value="alacritty"/>
          <property name="&lt;Alt&gt;space" type="string" value="xfce4-appfinder"/>
          <property name="&lt;Alt&gt;s" type="string" value="maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;s" type="string" value="maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"/>
          <property name="Print" type="string" value="maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"/>
          <property name="&lt;Alt&gt;Print" type="string" value="maim -i $(xdotool getactivewindow) ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"/>
          <property name="XF86AudioRaiseVolume" type="string" value="pactl set-sink-volume @DEFAULT_SINK@ +5%"/>
          <property name="XF86AudioLowerVolume" type="string" value="pactl set-sink-volume @DEFAULT_SINK@ -5%"/>
          <property name="XF86AudioMute" type="string" value="pactl set-sink-mute @DEFAULT_SINK@ toggle"/>
          <property name="XF86AudioPlay" type="string" value="playerctl play-pause"/>
          <property name="XF86AudioNext" type="string" value="playerctl next"/>
          <property name="XF86AudioPrev" type="string" value="playerctl previous"/>
        </property>
      </property>
      <property name="xfwm4" type="empty">
        <property name="custom" type="empty">
          <property name="&lt;Alt&gt;q" type="string" value="close_window_key"/>
          <property name="&lt;Alt&gt;f" type="string" value="fullscreen_key"/>
          <property name="&lt;Alt&gt;1" type="string" value="workspace_1_key"/>
          <property name="&lt;Alt&gt;2" type="string" value="workspace_2_key"/>
          <property name="&lt;Alt&gt;3" type="string" value="workspace_3_key"/>
          <property name="&lt;Alt&gt;4" type="string" value="workspace_4_key"/>
          <property name="&lt;Alt&gt;5" type="string" value="workspace_5_key"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;1" type="string" value="move_window_workspace_1_key"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;2" type="string" value="move_window_workspace_2_key"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;3" type="string" value="move_window_workspace_3_key"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;4" type="string" value="move_window_workspace_4_key"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;5" type="string" value="move_window_workspace_5_key"/>
          <property name="&lt;Alt&gt;m" type="string" value="move_window_workspace_9_key"/>
          <property name="&lt;Alt&gt;&lt;Shift&gt;m" type="string" value="workspace_9_key"/>
        </property>
      </property>
    </channel>
  '';
}

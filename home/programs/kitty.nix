{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 18;
    };
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      background_opacity = "0.95";
      window_padding_width = 4;
      hide_window_decorations = "titlebar-only";
      cursor_shape = "beam";
      cursor_beam_thickness = 2.0;
      shell_integration = "enabled";
      copy_on_select = "clipboard";
      scrollback_lines = 10000;
      mouse_hide_wait = "-1.0";
    };
  };
}

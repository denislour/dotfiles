{
  xdg.configFile."rofi/config.rasi".text = ''
    @theme "catppuccin-default"
  '';

  xdg.configFile."rofi/catppuccin-default.rasi".text = ''
    @import "themes/catppuccin-mocha"

    * {
      selected-active-foreground:  @background;
      lightfg:                     @text;
      separatorcolor:              @foreground;
      urgent-foreground:           @red;
      alternate-urgent-background: @lightbg;
      lightbg:                     @mantle;
      background-color:            transparent;
      border-color:                @foreground;
      normal-background:           @background;
      selected-urgent-background:  @red;
      alternate-active-background: @lightbg;
      spacing:                     2;
      alternate-normal-foreground: @foreground;
      urgent-background:           @background;
      selected-normal-foreground:  @lightbg;
      active-foreground:           @blue;
      background:                  @base;
      selected-active-background:  @blue;
      active-background:           @background;
      selected-normal-background:  @lightfg;
      alternate-normal-background: @lightbg;
      foreground:                  @text;
      selected-urgent-foreground:  @background;
      normal-foreground:           @foreground;
    }

    window {
      transparency:                "real";
      location:                    center;
      anchor:                      center;
      width:                       600px;
      border-radius:               12px;
    }

    mainbox {
      spacing:                     10px;
      padding:                     24px;
      children:                    [ "inputbar", "listview" ];
    }

    inputbar {
      spacing:                     10px;
      children:                    [ "textbox-prompt-colon", "entry" ];
    }

    textbox-prompt-colon {
      expand:                      false;
      str:                         "";
    }

    listview {
      spacing:                     6px;
      margin:                      12px 0px 0px 0px;
      lines:                       8;
    }

    element {
      padding:                     8px 12px;
      border-radius:               8px;
    }

    element-icon {
      size:                        1.2em;
    }

    element-text {
      vertical-align:              0.5;
    }

    message {
      margin:                      12px 0px 0px 0px;
    }

    textbox {
      padding:                     8px 12px;
      border-radius:               8px;
    }
  '';

  xdg.configFile."rofi/themes/catppuccin-mocha.rasi".text = ''
    * {
      rosewater: #f5e0dc;
      flamingo: #f2cdcd;
      pink: #f5c2e7;
      mauve: #cba6f7;
      red: #f38ba8;
      maroon: #eba0ac;
      peach: #fab387;
      yellow: #f9e2af;
      green: #a6e3a1;
      teal: #94e2d5;
      sky: #89dceb;
      sapphire: #74c7ec;
      blue: #89b4fa;
      lavender: #b4befe;
      text: #cdd6f4;
      subtext1: #bac2de;
      subtext0: #a6adc8;
      overlay2: #9399b2;
      overlay1: #7f849c;
      overlay0: #6c7086;
      surface2: #585b70;
      surface1: #45475a;
      surface0: #313244;
      base: #1e1e2e;
      mantle: #181825;
      crust: #11111b;
    }
  '';
}

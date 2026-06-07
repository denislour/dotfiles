{
  xdg.configFile."rofi/config.rasi".text = ''
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

      lightfg:                     @text;
      lightbg:                     @mantle;
      background:                  @base;
      foreground:                  @text;
      selected-normal-background:  @lightfg;
      selected-normal-foreground:  @lightbg;
      normal-background:           @background;
      normal-foreground:           @foreground;
      urgent-background:           @background;
      urgent-foreground:           @red;
      active-background:           @background;
      active-foreground:           @blue;
      alternate-normal-background: @lightbg;
      alternate-normal-foreground: @foreground;
      selected-urgent-background:  @red;
      selected-urgent-foreground:  @background;
      selected-active-background:  @blue;
      selected-active-foreground:  @background;
      alternate-urgent-background: @lightbg;
      alternate-active-background: @lightbg;
    }

    configuration {
      modi:                       "drun,run,window";
      show-icons:                 true;
      icon-theme:                 "Papirus";
      display-drun:               " Apps";
      display-run:                " Run";
      display-window:             " Windows";
      drun-display-format:        "{name}";
      font:                       "JetBrainsMono Nerd Font 12";
    }

    window {
      transparency:                real;
      location:                    center;
      anchor:                      center;
      width:                       600;
      border-radius:               12;
      background-color:            @background;
    }

    mainbox {
      spacing:                     10;
      padding:                     24;
      background-color:            transparent;
      children:                    [ "inputbar", "listview" ];
    }

    inputbar {
      spacing:                     10;
      background-color:            transparent;
      children:                    [ "textbox-prompt-colon", "entry" ];
    }

    textbox-prompt-colon {
      padding:                     6 0;
      expand:                      false;
      str:                         "";
      background-color:            transparent;
      text-color:                  @foreground;
    }

    entry {
      padding:                     6 0;
      background-color:            transparent;
      text-color:                  @foreground;
      placeholder:                 "Search";
      placeholder-color:           @overlay0;
    }

    listview {
      spacing:                     6;
      margin:                      12 0 0 0;
      lines:                       8;
      columns:                     1;
      cycle:                       true;
      dynamic:                     true;
      scrollbar:                   true;
      layout:                      vertical;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    scrollbar {
      handle-width:                4;
      handle-color:                @mauve;
      border-radius:               4;
      background-color:            transparent;
    }

    element {
      padding:                     8 12;
      border-radius:               8;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    element normal.normal {
      background-color:            transparent;
      text-color:                  @foreground;
    }

    element selected.normal {
      background-color:            @mauve;
      text-color:                  @base;
    }

    element-icon {
      size:                        1.2em;
      vertical-align:              0.5;
      horizontal-align:            0.5;
    }

    element-text {
      vertical-align:              0.5;
      horizontal-align:            0.0;
    }

    message {
      spacing:                     8;
      margin:                      12 0 0 0;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    textbox {
      padding:                     8 12;
      border-radius:               8;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    error-message {
      padding:                     12;
      border-radius:               12;
      background-color:            @base;
      text-color:                  @text;
    }
  '';
}

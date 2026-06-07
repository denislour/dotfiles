{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi:                       "drun,run,window";
      show-icons:                 true;
      icon-theme:                 "Papirus";
      display-drun:               " Apps";
      display-run:                " Run";
      display-window:             " Windows";
      drun-display-format:        "{name}";
      window-format:              "{w} · {c} · {t}";
      font:                       "JetBrainsMono Nerd Font 12";
    }

    * {
      background:                 #1e1e2e;
      foreground:                 #cdd6f4;
      selected:                   #cba6f7;
    }

    window {
      transparency:                "real";
      location:                    center;
      anchor:                      center;
      width:                       600px;
      border-radius:               12px;
      background-color:            @background;
    }

    mainbox {
      spacing:                     10px;
      padding:                     20px;
      background-color:            transparent;
      children:                    [ "inputbar", "listview" ];
    }

    inputbar {
      spacing:                     10px;
      padding:                     0px;
      background-color:            transparent;
      text-color:                  @foreground;
      children:                    [ "textbox-prompt-colon", "entry" ];
    }

    textbox-prompt-colon {
      padding:                     6px 0px;
      expand:                      false;
      str:                         "";
      background-color:            transparent;
      text-color:                  @foreground;
    }

    entry {
      padding:                     6px 0px;
      background-color:            transparent;
      text-color:                  @foreground;
      placeholder:                 "Search...";
    }

    listview {
      columns:                     1;
      lines:                       8;
      cycle:                       true;
      dynamic:                     true;
      scrollbar:                   true;
      layout:                      vertical;
      spacing:                     4px;
      margin:                      10px 0px 0px 0px;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    scrollbar {
      handle-width:                4px;
      handle-color:                @selected;
      border-radius:               4px;
      background-color:            transparent;
    }

    element {
      spacing:                     8px;
      padding:                     8px 12px;
      border-radius:               8px;
      background-color:            transparent;
      text-color:                  @foreground;
      cursor:                      pointer;
    }

    element normal.normal {
      background-color:            transparent;
      text-color:                  @foreground;
    }

    element selected.normal {
      background-color:            @selected;
      text-color:                  @background;
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
      spacing:                     8px;
      margin:                      10px 0px 0px 0px;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    textbox {
      padding:                     8px 12px;
      border-radius:               8px;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    error-message {
      padding:                     12px;
      border-radius:               12px;
      background-color:            @background;
      text-color:                  @foreground;
    }
  '';
}

{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi:                       "drun,run,window";
      show-icons:                 true;
      display-drun:               "";
      display-run:                "";
      display-window:             "";
      drun-display-format:        "{name}";
      window-format:              "{w} · {c} · {t}";
    }

    * {
      background:                 #1e1e2e;
      background-alt:             #313244;
      foreground:                 #cdd6f4;
      selected:                   #cba6f7;
      active:                     #a6e3a1;
      urgent:                     #f38ba8;
    }

    window {
      transparency:                "real";
      location:                    center;
      anchor:                      center;
      fullscreen:                  false;
      width:                       600px;
      border-radius:               10px;
      background-color:            @background;
    }

    mainbox {
      spacing:                     10px;
      padding:                     30px;
      background-color:            transparent;
      children:                    [ "inputbar", "message", "listview" ];
    }

    inputbar {
      spacing:                     10px;
      background-color:            transparent;
      text-color:                  @foreground;
      children:                    [ "textbox-prompt-colon", "entry", "mode-switcher" ];
    }

    textbox-prompt-colon {
      padding:                     5px 0px;
      expand:                      false;
      str:                         "";
      background-color:            inherit;
      text-color:                  inherit;
    }

    entry {
      padding:                     5px 0px;
      background-color:            inherit;
      text-color:                  inherit;
      placeholder:                 "Search...";
      placeholder-color:           inherit;
    }

    listview {
      columns:                     1;
      lines:                       8;
      cycle:                       true;
      dynamic:                     true;
      scrollbar:                   true;
      layout:                      vertical;
      spacing:                     5px;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    scrollbar {
      handle-width:                5px;
      handle-color:                @selected;
      border-radius:               10px;
      background-color:            @background-alt;
    }

    element {
      spacing:                     10px;
      padding:                     5px 10px;
      border-radius:               10px;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    element selected.normal {
      background-color:            @selected;
      text-color:                  @background;
    }

    element-icon {
      size:                        24px;
    }

    element-text {
      vertical-align:              0.5;
      horizontal-align:            0.0;
    }

    mode-switcher {
      spacing:                     10px;
      background-color:            transparent;
      text-color:                  @foreground;
    }

    button {
      padding:                     5px 10px;
      border-radius:               10px;
      background-color:            @background-alt;
      text-color:                  inherit;
    }

    button selected {
      background-color:            @selected;
      text-color:                  @background;
    }

    message {
      background-color:            transparent;
      text-color:                  @foreground;
    }

    textbox {
      padding:                     8px 10px;
      border-radius:               10px;
      background-color:            @background-alt;
      text-color:                  @foreground;
    }

    error-message {
      padding:                     10px;
      border:                      2px solid;
      border-radius:               10px;
      border-color:                @selected;
      background-color:            @background;
      text-color:                  @foreground;
    }
  '';
}

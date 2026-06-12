{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
    };
  };

  xdg.configFile."rofi/config.rasi".text = ''
    @theme "~/.config/rofi/style-5"

    configuration {
        modi:                    "drun,run,window";
        show-icons:              true;
        display-drun:            "";
        display-run:             "";
        display-window:          "";
        drun-display-format:     "{name}";
        font:                    "JetBrainsMonoNL Nerd Font 10";
    }
  '';

  xdg.configFile."rofi/style-5.rasi".text = ''
    * {
        background:                 #1e1e2e;
        background-alt:             #313244;
        foreground:                 #cdd6f4;
        selected:                   #cba6f7;
        active:                     #a6e3a1;
        urgent:                     #f38ba8;
        border-colour:              #cba6f7;
        handle-colour:              #cba6f7;
        background-colour:          #1e1e2e;
        foreground-colour:          #cdd6f4;
        alternate-background:       #313244;
        normal-background:          #1e1e2e;
        normal-foreground:          #cdd6f4;
        urgent-background:          #f38ba8;
        urgent-foreground:          #1e1e2e;
        active-background:          #a6e3a1;
        active-foreground:          #1e1e2e;
        selected-normal-background: #cba6f7;
        selected-normal-foreground: #1e1e2e;
        selected-urgent-background: #a6e3a1;
        selected-urgent-foreground: #1e1e2e;
        selected-active-background: #f38ba8;
        selected-active-foreground: #1e1e2e;
        alternate-normal-background:#1e1e2e;
        alternate-normal-foreground:#cdd6f4;
        alternate-urgent-background:#f38ba8;
        alternate-urgent-foreground:#1e1e2e;
        alternate-active-background:#a6e3a1;
        alternate-active-foreground:#1e1e2e;
    }

    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       600px;
        x-offset:                    0px;
        y-offset:                    0px;
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                var(border-colour);
        cursor:                      "default";
        background-color:            var(background-colour);
    }

    mainbox {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     30px;
        border:                      0px solid;
        border-radius:               0px;
        background-color:            transparent;
        children:                    [ "inputbar", "message", "listview" ];
    }

    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        text-color:                  var(foreground-colour);
        children:                    [ "textbox-prompt-colon", "entry", "mode-switcher" ];
    }

    textbox-prompt-colon {
        enabled:                     true;
        padding:                     5px 0px;
        expand:                      false;
        str:                         "";
        background-color:            inherit;
        text-color:                  inherit;
    }
    entry {
        enabled:                     true;
        padding:                     5px 0px;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search...";
        placeholder-color:           inherit;
    }

    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       8;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   true;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        spacing:                     5px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        text-color:                  var(foreground-colour);
        cursor:                      "default";
    }

    scrollbar {
        handle-width:                5px;
        handle-color:                var(handle-colour);
        border-radius:               10px;
        background-color:            var(alternate-background);
    }

    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        background-color:            transparent;
        text-color:                  var(foreground-colour);
        cursor:                      pointer;
    }

    element normal.normal {
        background-color:            var(normal-background);
        text-color:                  var(normal-foreground);
    }
    element normal.urgent {
        background-color:            var(urgent-background);
        text-color:                  var(urgent-foreground);
    }
    element normal.active {
        background-color:            var(active-background);
        text-color:                  var(active-foreground);
    }
    element selected.normal {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }
    element selected.urgent {
        background-color:            var(selected-urgent-background);
        text-color:                  var(selected-urgent-foreground);
    }
    element selected.active {
        background-color:            var(selected-active-background);
        text-color:                  var(selected-active-foreground);
    }
    element alternate.normal {
        background-color:            var(alternate-normal-background);
        text-color:                  var(alternate-normal-foreground);
    }
    element alternate.urgent {
        background-color:            var(alternate-urgent-background);
        text-color:                  var(alternate-urgent-foreground);
    }
    element alternate.active {
        background-color:            var(alternate-active-background);
        text-color:                  var(alternate-active-foreground);
    }

    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        24px;
        cursor:                      inherit;
    }

    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    mode-switcher {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        text-color:                  var(foreground-colour);
    }

    button {
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        background-color:            var(alternate-background);
        text-color:                  inherit;
        cursor:                      pointer;
    }

    button selected {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }

    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        text-color:                  var(foreground-colour);
    }

    textbox {
        padding:                     8px 10px;
        border:                      0px solid;
        border-radius:               10px;
        background-color:            var(alternate-background);
        text-color:                  var(foreground-colour);
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
        markup:                      true;
    }
  '';
}

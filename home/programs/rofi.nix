{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
    };
  };

  xdg.configFile."rofi/colors/catppuccin-mocha.rasi".text = ''
    * {
        background:     #1e1e2e;
        background-alt: #313244;
        foreground:     #cdd6f4;
        selected:       #cba6f7;
        active:         #a6e3a1;
        urgent:         #f38ba8;
    }
  '';

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
        border-colour:               @selected;
        handle-colour:               @selected;
        background-colour:           @background;
        foreground-colour:           @foreground;
        alternate-background:        @background-alt;
        normal-background:           @background;
        normal-foreground:           @foreground;
        urgent-background:           @urgent;
        urgent-foreground:           @background;
        active-background:           @active;
        active-foreground:           @background;
        selected-normal-background:  @selected;
        selected-normal-foreground:  @background;
        selected-urgent-background:  @active;
        selected-urgent-foreground:  @background;
        selected-active-background:  @urgent;
        selected-active-foreground:  @background;
        alternate-normal-background: @background;
        alternate-normal-foreground: @foreground;
        alternate-urgent-background: @urgent;
        alternate-urgent-foreground: @background;
        alternate-active-background: @active;
        alternate-active-foreground: @background;
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
        border-color:                @border-colour;
        cursor:                      "default";
        background-color:            @background-colour;
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
        text-color:                  @foreground-colour;
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
        text-color:                  @foreground-colour;
        cursor:                      "default";
    }

    scrollbar {
        handle-width:                5px;
        handle-color:                @handle-colour;
        border-radius:               10px;
        background-color:            @alternate-background;
    }

    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      pointer;
    }

    element normal.normal {
        background-color:            @normal-background;
        text-color:                  @normal-foreground;
    }
    element normal.urgent {
        background-color:            @urgent-background;
        text-color:                  @urgent-foreground;
    }
    element normal.active {
        background-color:            @active-background;
        text-color:                  @active-foreground;
    }
    element selected.normal {
        background-color:            @selected-normal-background;
        text-color:                  @selected-normal-foreground;
    }
    element selected.urgent {
        background-color:            @selected-urgent-background;
        text-color:                  @selected-urgent-foreground;
    }
    element selected.active {
        background-color:            @selected-active-background;
        text-color:                  @selected-active-foreground;
    }
    element alternate.normal {
        background-color:            @alternate-normal-background;
        text-color:                  @alternate-normal-foreground;
    }
    element alternate.urgent {
        background-color:            @alternate-urgent-background;
        text-color:                  @alternate-urgent-foreground;
    }
    element alternate.active {
        background-color:            @alternate-active-background;
        text-color:                  @alternate-active-foreground;
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
        text-color:                  @foreground-colour;
    }

    button {
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        background-color:            @alternate-background;
        text-color:                  inherit;
        cursor:                      pointer;
    }

    button selected {
        background-color:            @selected-normal-background;
        text-color:                  @selected-normal-foreground;
    }

    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }

    textbox {
        padding:                     8px 10px;
        border:                      0px solid;
        border-radius:               10px;
        background-color:            @alternate-background;
        text-color:                  @foreground-colour;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
        markup:                      true;
    }
  '';
}

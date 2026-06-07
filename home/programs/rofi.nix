{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi:                       "drun,run,window";
      show-icons:                 true;
      icon-theme:                 "Papirus";
      display-drun:               "";
      display-run:                "";
      display-window:             "";
      drun-display-format:        "{name}";
      font:                       "JetBrainsMonoNL Nerd Font 12";
    }

    * {
      base: #1e1e2e;
      surface0: #313244;
      overlay0: #6c7086;
      text: #cdd6f4;
      mauve: #cba6f7;
      red: #f38ba8;
      peach: #fab387;
      green: #a6e3a1;
      lavender: #b4befe;
      background-color: @base;
    }

    window {
      width: 600;
      border-radius: 10;
      border: 2;
      border-color: @lavender;
    }

    mainbox {
      spacing: 0;
      children: [ inputbar, message, listview ];
    }

    inputbar {
      padding: 14;
      background-color: @base;
      text-color: @text;
    }

    entry {
      text-color: @text;
      placeholder: "Search";
      placeholder-color: @overlay0;
    }

    prompt {
      text-color: @text;
      margin: 0 10 0 0;
    }

    textbox-prompt-colon {
      str: "";
      text-color: @text;
      margin: 0 10 0 0;
    }

    listview {
      padding: 8;
      background-color: @base;
      dynamic: false;
      lines: 8;
      spacing: 4;
    }

    scrollbar {
      handle-width: 4;
      handle-color: @mauve;
      border-radius: 4;
    }

    element {
      padding: 8 12;
      border-radius: 10;
      background-color: transparent;
      text-color: @text;
    }

    element normal.normal {
      background-color: @surface0;
      text-color: @text;
    }

    element selected.normal {
      background-color: @mauve;
      text-color: @base;
    }

    element-icon {
      size: 1.2em;
      vertical-align: 0.5;
      margin: 0 10 0 0;
    }

    element-text {
      vertical-align: 0.5;
      background-color: inherit;
      text-color: inherit;
    }

    message {
      padding: 10;
      background-color: @overlay0;
      text-color: @base;
    }

    error-message {
      border: 12;
      background-color: @base;
      text-color: @text;
    }
  '';
}

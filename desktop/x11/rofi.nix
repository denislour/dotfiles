{ pkgs, ... }: {
  home.packages = with pkgs; [ rofi ];

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      font: "JetBrainsMono NF Bold 9";
      show-icons: true;
      icon-theme: "Papirus";
      terminal: "ghostty";
      drun-display-format: "{name}";
      display-drun: "Apps";
      display-run: "Run";
      display-window: "Window";
      sidebar-mode: false;
    }

    * {
      bg-col: #2d353b;
      bg-alt: #272e33;
      fg-col: #d3c6aa;
      sel-col: #7fbbb3;
      urgent-col: #e67e80;
      background-color: transparent;
      text-color: @fg-col;
    }

    window {
      background-color: @bg-col;
      border: 0px;
      padding: 6px;
      border-radius: 6px;
      width: 400px;
    }

    mainbox {
      border: 0px;
      padding: 0px;
    }

    inputbar {
      spacing: 0px;
      padding: 6px;
      text-color: @fg-col;
      background-color: @bg-alt;
      border-radius: 6px;
    }

    listview {
      columns: 1;
      lines: 8;
      padding: 6px 0px 0px;
    }

    element {
      padding: 4px 8px;
      border-radius: 6px;
    }

    element selected {
      background-color: @sel-col;
      text-color: @bg-col;
    }

    element urgent {
      background-color: @urgent-col;
      text-color: @bg-col;
    }
  '';
}

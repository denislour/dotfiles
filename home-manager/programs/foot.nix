{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=10";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      scrollback = {
        lines = 10000;
      };
      "colors-dark" = {
        background = "1a1b26";
        foreground = "c0caf5";
        selection-foreground = "c0caf5";
        selection-background = "2f3346";
        regular0 = "1a1b26";
        regular1 = "f7768e";
        regular2 = "9ece6a";
        regular3 = "e0af68";
        regular4 = "7aa2f7";
        regular5 = "bb9af7";
        regular6 = "7dcfff";
        regular7 = "c0caf5";
        bright0 = "414868";
        bright1 = "f7768e";
        bright2 = "9ece6a";
        bright3 = "e0af68";
        bright4 = "7aa2f7";
        bright5 = "bb9af7";
        bright6 = "7dcfff";
        bright7 = "c0caf5";
      };
    };
  };
}

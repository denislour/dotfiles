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
    };
  };
}

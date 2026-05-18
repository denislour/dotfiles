{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      mouse = {
        hide-when-typing = "yes";
      };
      scrollback = {
        lines = 10000;
      };
    };
  };
}

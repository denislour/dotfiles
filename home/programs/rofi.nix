{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "";
      display-run = "";
      display-window = "";
      drun-display-format = "{name}";
      font = "JetBrainsMonoNL Nerd Font 12";
      location = 0;
      yoffset = -100;
    };
  };
}

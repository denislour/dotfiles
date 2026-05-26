{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server = {
      enable = false;
    };
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=18";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}

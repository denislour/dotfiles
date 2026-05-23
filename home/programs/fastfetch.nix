{ ... }: let
  dogeLogo = ./doge.txt;
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "file-raw";
        source = "${dogeLogo}";
        padding = { left = 2; };
      };
      display = {
        separator = " → ";
        color = "blue";
      };
      modules = "default";
    };
  };
}

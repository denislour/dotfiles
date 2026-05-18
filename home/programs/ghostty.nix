{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 11;
      font-family = "JetBrainsMono Nerd Font";
      window-decoration = false;
      font-feature = [
        "-liga"
        "-dlig"
        "-calt"
      ];
    };
  };
}

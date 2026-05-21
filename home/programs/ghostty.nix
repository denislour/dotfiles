{
  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    installBatSyntax = true;

    settings = {
      font-size = 13;
      font-family = "JetBrainsMono Nerd Font";
      window-decoration = false;
      background-opacity = 0.95;
      confirm-close-surface = false;
      copy-on-select = "clipboard";
      cursor-style = "bar";
      shell-integration = "zsh";
      font-feature = [
        "-liga"
        "-dlig"
        "-calt"
      ];
      theme = "Catppuccin Mocha";
    };
  };
}

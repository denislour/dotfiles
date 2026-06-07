{ pkgs, lib, ... }: {
  programs.alacritty.enable = true;

  programs.alacritty.settings = {
    terminal.shell.program = "${pkgs.zellij}/bin/zellij";

    window = {
      padding = { x = 8; y = 8; };
      decorations = "Full";
    };

    font = lib.mkForce {
      normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
      bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
      italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
      size = 14;
    };
  };
}

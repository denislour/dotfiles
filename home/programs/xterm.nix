{ pkgs, ... }: {
  home.packages = with pkgs; [ xterm ];

  home.file.".Xresources".text = ''
    XTerm*background: black
    XTerm*foreground: wheat
    XTerm*cursorColor: white
    XTerm*faceName: JetBrainsMono Nerd Font
    XTerm*faceSize: 14
    XTerm*modifyOtherKeys: 2
  '';
}

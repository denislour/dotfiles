{ pkgs, ... }: {
  home.packages = with pkgs; [ xterm ];

  xresources.extraConfig = ''
    XTerm*faceName: JetBrainsMono Nerd Font
    XTerm*faceSize: 16
    XTerm*renderFont: true
    XTerm*background: #2d353b
    XTerm*foreground: #d3c6aa
    XTerm*cursorColor: #d3c6aa
    XTerm*color0: #2d353b
    XTerm*color1: #e67e80
    XTerm*color2: #a7c080
    XTerm*color3: #dbbc7f
    XTerm*color4: #7fbbb3
    XTerm*color5: #d699b6
    XTerm*color6: #83c092
    XTerm*color7: #d3c6aa
    XTerm*color8: #475258
    XTerm*color9: #e67e80
    XTerm*color10: #a7c080
    XTerm*color11: #dbbc7f
    XTerm*color12: #7fbbb3
    XTerm*color13: #d699b6
    XTerm*color14: #83c092
    XTerm*color15: #f8f5e4
    XTerm*modifyOtherKeys: 2
    XTerm*formatOtherKeys: 1
  '';
}

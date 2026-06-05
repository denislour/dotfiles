{ pkgs, ... }:
let
  stConfig = pkgs.writeText "config.h" ''
    static const char *fontname     = "JetBrainsMono Nerd Font:size=10:antialias=true";
    static const char *altfont      = "JetBrainsMono Nerd Font:size=10:antialias=true";
    static const int borderpx       = 2;

    static const char *colorname[] = {
      "#2d353b",
      "#e67e80",
      "#a7c080",
      "#dbbc7f",
      "#7fbbb3",
      "#d699b6",
      "#83c092",
      "#d3c6aa",
      "#475258",
      "#e67e80",
      "#a7c080",
      "#dbbc7f",
      "#7fbbb3",
      "#d699b6",
      "#83c092",
      "#f8f5e4",
      [255] = 0,
      "#e6e2cc",
      "#2d353b",
      "#475258",
      "#d3c6aa",
    };

    unsigned int defaultfg = 7;
    unsigned int defaultbg = 0;

    static unsigned int defaultcs = 256;
    static unsigned int defaultrcs = 257;

    static const int bellstyle      = 2;
    static const int scrollback     = 1000;

    static char worddelimiters[] = " ";
  '';
in {
  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (old: {
        postPatch = ''
          cp ${stConfig} config.h
        '';
      });
    })
  ];

  home.packages = with pkgs; [ st ];
}

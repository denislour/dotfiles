{ pkgs, ... }:
let
  dmenuConfig = pkgs.writeText "config.h" ''
    static const char *fonts[] = {
      "JetBrainsMono Nerd Font:size=10:antialias=true",
    };

    static const char *colors[SchemeLast][2] = {
      [SchemeNorm] = { "#d3c6aa", "#2d353b" },
      [SchemeSel]  = { "#f8f5e4", "#7fbbb3" },
      [SchemeOut]  = { "#f8f5e4", "#d699b6" },
    };

    static const unsigned int alphas[SchemeLast][2] = {
      [SchemeNorm] = { OPAQUE, OPAQUE },
      [SchemeSel]  = { OPAQUE, OPAQUE },
      [SchemeOut]  = { OPAQUE, OPAQUE },
    };

    static const unsigned int lines      = 10;
    static const unsigned int columns    = 1;
    static const unsigned int menuitem   = 0;
    static const unsigned int menuwidth  = 0;
    static const char *prompt      = NULL;
    static const char *dynamic     = NULL;
    static const int showprompt    = 1;
    static const int fuzzy         = 1;
    static const int caseinsensitive = 1;
    static const int topbar        = 1;
    static const int incremental   = 0;
    static const int restrict      = 0;
    static const unsigned int gold     = 0;
    static const int preselected = 0;
  '';
in {
  nixpkgs.overlays = [
    (self: super: {
      dmenu = super.dmenu.overrideAttrs (old: {
        postPatch = ''
          cp ${dmenuConfig} config.h
        '';
      });
    })
  ];

  home.packages = with pkgs; [ dmenu ];
}

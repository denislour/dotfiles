{ pkgs, ... }:
let
  dwmConfig = pkgs.writeText "config.h" ''
    static const unsigned int borderpx  = 2;
    static const unsigned int snap      = 32;
    static const int showbar            = 1;
    static const int topbar             = 1;
    static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=10:antialias=true" };
    static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=10:antialias=true";
    static char dmenumon[2]          = "0";
    static const char col_gray1[]       = "#2d353b";
    static const char col_gray2[]       = "#475258";
    static const char col_gray3[]       = "#d3c6aa";
    static const char col_gray4[]       = "#e6e2cc";
    static const char col_cyan[]        = "#7fbbb3";

    static const char *colors[][3]      = {
      [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
      [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
    };

    static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

    static const Rule rules[] = {
      { "Gimp",     NULL,       NULL,       0,            1,           -1 },
      { "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
    };

    static const float mfact     = 0.55;
    static const int nmaster     = 1;
    static const int resizehints = 1;
    static const int lockfullscreen = 1;

    static const Layout layouts[] = {
      { "[]=",      tile },
      { "><>",      NULL },
      { "[M]",      monocle },
    };

    #define MODKEY Mod1Mask
    #define TAGKEYS(KEY,TAG) \
      { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
      { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
      { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
      { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

    static const char *dmenucmd[]   = { "${pkgs.dmenu}/bin/dmenu_run", "-fn", fonts[0], "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4 };
    static const char *termcmd[]    = { "${pkgs.ghostty}/bin/ghostty" };
    static const char *scrotcmd[]   = { "sh", "-c", "${pkgs.maim}/bin/maim -u ~/Pictures/screenshot-$(date +%s).png" };
    static const char *scrotselcmd[] = { "sh", "-c", "${pkgs.maim}/bin/maim -su ~/Pictures/screenshot-$(date +%s).png" };
    static const char *volupcmd[]   = { "${pkgs.wireplumber}/bin/wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05+" };
    static const char *voldowncmd[] = { "${pkgs.wireplumber}/bin/wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05-" };
    static const char *volmutecmd[] = { "${pkgs.wireplumber}/bin/wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle" };
    static const char *brightupcmd[]  = { "${pkgs.brightnessctl}/bin/brightnessctl", "s", "5+" };
    static const char *brightdowncmd[] = { "${pkgs.brightnessctl}/bin/brightnessctl", "s", "5-" };

    static Key keys[] = {
      { MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
      { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
      { MODKEY,                       XK_q,      killclient,     {0} },
      { MODKEY,                       XK_space,  setlayout,      {0} },
      { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
      { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[2]} },
      { MODKEY,                       XK_Tab,    view,           {0} },
      { MODKEY|ShiftMask,             XK_q,      quit,           {0} },    

      { MODKEY,                       XK_h,      focusstack,     {.i = -1 } },
      { MODKEY,                       XK_l,      focusstack,     {.i = +1 } },
      { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
      { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },

      { MODKEY|ShiftMask,             XK_h,      setmfact,       {.f = -0.05} },
      { MODKEY|ShiftMask,             XK_l,      setmfact,       {.f = +0.05} },

      { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
      { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
      { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
      { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

      TAGKEYS(                        XK_1,                      0)
      TAGKEYS(                        XK_2,                      1)
      TAGKEYS(                        XK_3,                      2)
      TAGKEYS(                        XK_4,                      3)
      TAGKEYS(                        XK_5,                      4)
      TAGKEYS(                        XK_6,                      5)
      TAGKEYS(                        XK_7,                      6)
      TAGKEYS(                        XK_8,                      7)
      TAGKEYS(                        XK_9,                      8)

      { 0,                            XK_Print,   spawn,          {.v = scrotcmd } },
      { ShiftMask,                    XK_Print,   spawn,          {.v = scrotselcmd } },

      { 0,                            XF86XK_AudioLowerVolume,  spawn, {.v = voldowncmd } },
      { 0,                            XF86XK_AudioRaiseVolume,  spawn, {.v = volupcmd } },
      { 0,                            XF86XK_AudioMute,          spawn, {.v = volmutecmd } },
      { 0,                            XF86XK_MonBrightnessDown, spawn, {.v = brightdowncmd } },
      { 0,                            XF86XK_MonBrightnessUp,   spawn, {.v = brightupcmd } },
    };

    static Button buttons[] = {
      { MODKEY, Button1,   movemouse,     {0} },
      { MODKEY, Button2,   togglefloating, {0} },
      { MODKEY, Button3,   resizemouse,   {0} },
      { MODKEY, Button4,   focusstack,    {.i = -1 } },
      { MODKEY, Button5,   focusstack,    {.i = +1 } },
    };
  '';
  dwmCustom = pkgs.dwm.overrideAttrs (old: {
    postPatch = ''
      cp ${dwmConfig} config.h
    '';
  });
in {
  services.displayManager.defaultSession = "none+dwm";
  services.xserver.windowManager.dwm = {
    enable = true;
    package = dwmCustom;
  };
}

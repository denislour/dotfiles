{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, stylix, niri, noctalia, sops-nix, ... } @ inputs:
    let
      system = "x86_64-linux";
      overlays.default = final: prev:
        let
          configH = final.writeText "config.def.h" ''
        /* See LICENSE file for copyright and license details. */

        #include <X11/XF86keysym.h>

        /* appearance */
        static const unsigned int borderpx  = 3;
        static const unsigned int default_border = 3;
        static const unsigned int snap      = 32;
        static const unsigned int gappih    = 10;
        static const unsigned int gappiv    = 10;
        static const unsigned int gappoh    = 10;
        static const unsigned int gappov    = 10;
        static const int smartgaps          = 0;
        static const unsigned int systraypinning = 0;
        static const unsigned int systrayspacing = 8;
        static const unsigned int systrayiconsize = 20;
        static const int systraypinningfailfirst = 1;
        static const int showsystray        = 1;
        static const int showbar            = 1;
        static const int showtab            = showtab_auto;
        static const int toptab             = 1;
        static const int floatbar           = 1;
        static const int topbar             = 1;
        static const int horizpadbar        = 5;
        static const int vertpadbar         = 11;
        static const int vertpadtab         = 35;
        static const int horizpadtabi       = 15;
        static const int horizpadtabo       = 15;
        static const int scalepreview       = 4;
        static const int tag_preview        = 0;
        static const int colorfultag        = 1;
        static const char *upvol[]   = { "/run/current-system/sw/bin/pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%",     NULL };
        static const char *downvol[] = { "/run/current-system/sw/bin/pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%",     NULL };
        static const char *mutevol[] = { "/run/current-system/sw/bin/pactl", "set-sink-mute",   "@DEFAULT_SINK@", "toggle",  NULL };
        static const int new_window_attach_on_end = 0;
        #define ICONSIZE 19
        #define ICONSPACING 8

        static const char *fonts[] = {"JetBrainsMono Nerd Font:style:medium:size=12", "JetBrainsMono Nerd Font Mono:style:medium:size=19"};

        // theme
        #include "themes/tundra.h"

        static const char *colors[][3] = {
            /*                     fg       bg      border */
            [SchemeNorm]       = { gray3,   black,  gray2 },
            [SchemeSel]        = { gray4,   blue,   gray3  },
            [SchemeTitle]      = { white,   black,  black },
            [TabSel]           = { blue,    gray2,  black },
            [TabNorm]          = { gray3,   black,  black },
            [SchemeTag]        = { gray3,   black,  black },
            [SchemeTag1]       = { blue,    black,  black },
            [SchemeTag2]       = { red,     black,  black },
            [SchemeTag3]       = { orange,  black,  black },
            [SchemeTag4]       = { green,   black,  black },
            [SchemeTag5]       = { pink,    black,  black },
            [SchemeLayout]     = { green,   black,  black },
            [SchemeBtnPrev]    = { green,   black,  black },
            [SchemeBtnNext]    = { yellow,  black,  black },
            [SchemeBtnClose]   = { red,     black,  black },
        };

        /* tagging */
        static char *tags[] = {"", "", "", "", ""};

        static const char* rofi_launcher[] = { "rofi", "-show", "drun", NULL };
        static const char* librewolf_launcher[] = { "librewolf", NULL };
        static const char* alacritty_launcher[] = { "alacritty", NULL };
        static const Launcher launchers[] = {
            { rofi_launcher, "  " },
            { librewolf_launcher, "  " },
            { alacritty_launcher, "  " },
        };

        static const int tagschemes[] = {
            SchemeTag1, SchemeTag2, SchemeTag3, SchemeTag4, SchemeTag5
        };

        static const unsigned int ulinepad      = 5;
        static const unsigned int ulinestroke   = 2;
        static const unsigned int ulinevoffset  = 0;
        static const int ulineall               = 0;

        static const Rule rules[] = {
            /* xprop(1):
             *	WM_CLASS(STRING) = instance, class
             *	WM_NAME(STRING) = title
             */
            /* class      instance    title       tags mask     iscentered   isfloating   monitor */
            { "Gimp",     NULL,       NULL,       0,            0,           1,           -1 },
            { "Firefox",  NULL,       NULL,       1 << 8,       0,           0,           -1 },
        };

        /* layout(s) */
        static const float mfact     = 0.50;
        static const int nmaster     = 1;
        static const int resizehints = 0;
        static const int lockfullscreen = 1;

        #define FORCE_VSPLIT 1
        #include "functions.h"

        static const Layout layouts[] = {
            /* symbol     arrange function */
            { "[]=",      tile },
            { "[M]",      monocle },
            { "[@]",      spiral },
            { "[\\]",     dwindle },
            { "H[]",      deck },
            { "TTT",      bstack },
            { "===",      bstackhoriz },
            { "HHH",      grid },
            { "###",      nrowgrid },
            { "---",      horizgrid },
            { ":::",      gaplessgrid },
            { "|M|",      centeredmaster },
            { ">M>",      centeredfloatingmaster },
            { "><>",      NULL },
            { NULL,       NULL },
        };

        /* key definitions */
        #define MODKEY Mod1Mask
        #define TAGKEYS(KEY,TAG) \
            { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
            { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
            { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
            { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

        /* helper for spawning shell commands in the pre dwm-5.0 fashion */
        #define SHCMD(cmd) { .v = (const char*[]){ "/run/current-system/sw/bin/bash", "-c", cmd, NULL } }

        /* commands */

        static const Key keys[] = {
            /* modifier                         key         function        argument */

            // brightness and audio 
            {0,             XF86XK_AudioLowerVolume,    spawn, {.v = downvol}},
            {0,             XF86XK_AudioMute, spawn,    {.v = mutevol }},
            {0,             XF86XK_AudioRaiseVolume,    spawn, {.v = upvol}},

            // screenshot fullscreen and cropped
            {MODKEY|ControlMask,                XK_u,       spawn,
                SHCMD("maim | xclip -selection clipboard -t image/png")},
            {MODKEY,                            XK_u,       spawn,
                SHCMD("maim --select | xclip -selection clipboard -t image/png")},



            // toggle stuff
            { MODKEY,                           XK_b,       togglebar,      {0} },
            { MODKEY|ControlMask,               XK_t,       togglegaps,     {0} },
            { MODKEY|ShiftMask,                 XK_space,   togglefloating, {0} },
            { MODKEY,                           XK_f,       togglefullscr,  {0} },

            { MODKEY|ControlMask,               XK_w,       tabmode,        { -1 } },
            { MODKEY,                           XK_j,       focusstack,     {.i = +1 } },
            { MODKEY,                           XK_k,       focusstack,     {.i = -1 } },
            { MODKEY,                           XK_i,       incnmaster,     {.i = +1 } },
            { MODKEY,                           XK_o,       incnmaster,     {.i = -1 } },

            // shift view
            { MODKEY,                           XK_Left,    shiftview,      {.i = -1 } },
            { MODKEY,                           XK_Right,   shiftview,      {.i = +1 } },

            // change mfact sizes 
            { MODKEY,                           XK_h,       setmfact,       {.f = -0.05} },
            { MODKEY,                           XK_l,       setmfact,       {.f = +0.05} },
            { MODKEY|ShiftMask,                 XK_h,       setcfact,       {.f = +0.25} },
            { MODKEY|ShiftMask,                 XK_l,       setcfact,       {.f = -0.25} },
            { MODKEY|ShiftMask,                 XK_o,       setcfact,       {.f =  0.00} },

            { MODKEY|ShiftMask,                 XK_j,       movestack,      {.i = +1 } },
            { MODKEY|ShiftMask,                 XK_k,       movestack,      {.i = -1 } },
            { MODKEY|ShiftMask,                 XK_Return,  zoom,           {0} },
            { MODKEY,                           XK_Tab,     view,           {0} },

            // overall gaps
            { MODKEY|ControlMask,               XK_i,       incrgaps,       {.i = +1 } },
            { MODKEY|ControlMask,               XK_o,       incrgaps,       {.i = -1 } },

            // inner gaps
            { MODKEY|ShiftMask,                 XK_i,       incrigaps,      {.i = +1 } },
            { MODKEY|ControlMask|ShiftMask,     XK_i,       incrigaps,      {.i = -1 } },

            // outer gaps
            { MODKEY|ControlMask,               XK_o,       incrogaps,      {.i = +1 } },
            { MODKEY|ControlMask|ShiftMask,     XK_o,       incrogaps,      {.i = -1 } },

            // inner+outer hori, vert gaps 
            { MODKEY|ControlMask,               XK_6,       incrihgaps,     {.i = +1 } },
            { MODKEY|ControlMask|ShiftMask,     XK_6,       incrihgaps,     {.i = -1 } },
            { MODKEY|ControlMask,               XK_7,       incrivgaps,     {.i = +1 } },
            { MODKEY|ControlMask|ShiftMask,     XK_7,       incrivgaps,     {.i = -1 } },
            { MODKEY|ControlMask,               XK_8,       incrohgaps,     {.i = +1 } },
            { MODKEY|ControlMask|ShiftMask,     XK_8,       incrohgaps,     {.i = -1 } },
            { MODKEY|ControlMask,               XK_9,       incrovgaps,     {.i = +1 } },
            { MODKEY|ControlMask|ShiftMask,     XK_9,       incrovgaps,     {.i = -1 } },

            { MODKEY|ControlMask|ShiftMask,     XK_d,       defaultgaps,    {0} },

            // layout
            { MODKEY,                           XK_t,       setlayout,      {.v = &layouts[0]} },
            { MODKEY|ShiftMask,                 XK_f,       setlayout,      {.v = &layouts[1]} },
            { MODKEY,                           XK_m,       setlayout,      {.v = &layouts[2]} },
            { MODKEY|ControlMask,               XK_g,       setlayout,      {.v = &layouts[10]} },
            { MODKEY|ControlMask|ShiftMask,     XK_t,       setlayout,      {.v = &layouts[13]} },
            { MODKEY,                           XK_space,   setlayout,      {0} },
            { MODKEY|ControlMask,               XK_comma,   cyclelayout,    {.i = -1 } },
            { MODKEY|ControlMask,               XK_period,  cyclelayout,    {.i = +1 } },
            { MODKEY,                           XK_0,       view,           {.ui = ~0 } },
            { MODKEY|ShiftMask,                 XK_0,       tag,            {.ui = ~0 } },
            { MODKEY,                           XK_comma,   focusmon,       {.i = -1 } },
            { MODKEY,                           XK_period,  focusmon,       {.i = +1 } },
            { MODKEY|ShiftMask,                 XK_comma,   tagmon,         {.i = -1 } },
            { MODKEY|ShiftMask,                 XK_period,  tagmon,         {.i = +1 } },

            // change border size
            { MODKEY|ShiftMask,                 XK_minus,   setborderpx,    {.i = -1 } },
            { MODKEY|ShiftMask,                 XK_p,       setborderpx,    {.i = +1 } },
            { MODKEY|ShiftMask,                 XK_w,       setborderpx,    {.i = default_border } },

            // kill dwm
            { MODKEY|ControlMask,               XK_q,       spawn,        SHCMD("killall chadwm") },

            // kill window
            { MODKEY,                           XK_q,       killclient,     {0} },

            // restart
            { MODKEY|ShiftMask,                 XK_r,       restart,           {0} },

            // hide & restore windows
            { MODKEY,                           XK_e,       hidewin,        {0} },
            { MODKEY|ShiftMask,                 XK_e,       restorewin,     {0} },

            TAGKEYS(                            XK_1,                       0)
            TAGKEYS(                            XK_2,                       1)
            TAGKEYS(                            XK_3,                       2)
            TAGKEYS(                            XK_4,                       3)
            TAGKEYS(                            XK_5,                       4)
            TAGKEYS(                            XK_6,                       5)
            TAGKEYS(                            XK_7,                       6)
            TAGKEYS(                            XK_8,                       7)
            TAGKEYS(                            XK_9,                       8)
        };

        /* button definitions */
        static const Button buttons[] = {
            { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
            { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
            { ClkWinTitle,          0,              Button2,        zoom,           {0} },
            { ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 0} },
            { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
            { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
            { ClkClientWin,         ControlMask,    Button1,        dragmfact,      {0} },
            { ClkClientWin,         ControlMask,    Button3,        dragcfact,      {0} },
            { ClkTagBar,            0,              Button1,        view,           {0} },
            { ClkTagBar,            0,              Button3,        toggleview,     {0} },
            { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
            { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
            { ClkTabBar,            0,              Button1,        focuswin,       {0} },
            { ClkTabPrev,           0,              Button1,        movestack,      { .i = -1 } },
            { ClkTabNext,           0,              Button1,        movestack,      { .i = +1 } },
            { ClkTabClose,          0,              Button1,        killclient,     {0} },
        };
      '';
        in {
        chadwm = prev.dwm.overrideAttrs (old: {
          pname = "chadwm";
          version = "6.5-unstable-2025-12-30";
          src = final.fetchFromGitHub {
            owner = "siduck";
            repo = "chadwm";
            rev = "7991ac8d33878b716e7e7cabf58b47503864f622";
            hash = "sha256-4Bunr/rRF6UUOBV/LTK4gyrekXRFWdaCxkWNYfp44Jo=";
          };
          sourceRoot = "source/chadwm";
          buildInputs = old.buildInputs ++ [ final.imlib2 final.libxrender ];
          postPatch = (old.postPatch or "") + ''
            cp ${configH} config.def.h
          '';
        });
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlays.default ];
      };
      sharedModules = [
        stylix.nixosModules.stylix
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        { nixpkgs.overlays = [ overlays.default ]; }
        ./system/packages.nix
        ./system/environment.nix
        ./system/services/sops.nix
        ./system/common.nix
        ./system/programs/stylix.nix
        ./system/programs/xdg-portal.nix
        ./system/services/ssh.nix

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [];
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    in {
      nixosConfigurations.my-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit self inputs;
          wallpaper = ./system/wallpapers/default.jpg;
        };
        modules = sharedModules ++ [
          ./hosts/my-vm/disk-config.nix
          ./hosts/my-vm/configuration.nix
          ./desktop/wayland/system.nix

          ({
            home-manager.users.jake = import ./hosts/my-vm/home.nix;
          })
        ];
      };

      nixosConfigurations.my-vm-x11 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit self inputs;
          wallpaper = ./system/wallpapers/default.jpg;
        };
        modules = sharedModules ++ [
          ./hosts/my-vm-x11/disk-config.nix
          ./hosts/my-vm-x11/configuration.nix
          ./desktop/x11/system.nix

          ({
            home-manager.users.jake = import ./hosts/my-vm-x11/home.nix;
          })
        ];
      };
    };
}

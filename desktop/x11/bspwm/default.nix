{ pkgs, ... }: {
  home.packages = with pkgs; [ bspwm sxhkd ];

  xdg.configFile."bspwm/bspwmrc".text = ''
    #!${pkgs.bash}/bin/bash

    ${pkgs.picom}/bin/picom -b
    ${pkgs.dunst}/bin/dunst &
    ${pkgs.feh}/bin/feh --bg-fill /run/current-system/sw/share/backgrounds/nixos/nix-wallpaper-simple-dark.png &
    ${pkgs.polybar}/bin/polybar main &
    ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent &
  '';

  xdg.configFile."bspwm/bspwmrc".executable = true;

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    super + Return
      ghostty
    super + q
      bspc node -c
    super + shift + q
      bspc quit
    super + alt + r
      bspc wm -r
    super + {1-9}
      bspc desktop -f '{1-9}'
    super + shift + {1-9}
      bspc node -d '{1-9}'
    super + {h,j,k,l}
      bspc node -f {left,down,up,right}
    super + shift + {h,j,k,l}
      bspc node -s {left,down,up,right}
    super + f
      bspc node -t ~fullscreen
    super + shift + space
      bspc node -t ~floating
    super + Tab
      bspc desktop -f next.local
    super + shift + Tab
      bspc desktop -f prev.local
    super + d
      rofi -show drun
    Print
      maim -u ~/Pictures/screenshot-$(date +%s).png
    shift + Print
      maim -su ~/Pictures/screenshot-$(date +%s).png
    XF86MonBrightness{Down,Up}
      brightnessctl s {5-,5+}
    XF86Audio{Lower,Raise}Volume
      wpctl set-volume @DEFAULT_AUDIO_SINK@ {0.05-,0.05+}
    XF86AudioMute
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  '';
}

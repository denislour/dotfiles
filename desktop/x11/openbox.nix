{ pkgs, ... }: {
  home.packages = with pkgs; [ dunst i3lock openbox picom polybar rofi ];

  xdg.configFile."openbox/rc.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <openbox_config xmlns="http://openbox.org/3.4/rc"
                    xmlns:xi="http://www.w3.org/2001/XInclude">
      <resistance>
        <strength>10</strength>
      </resistance>
      <focus>
        <focusNew>yes</focusNew>
        <followMouse>yes</followMouse>
        <focusLast>yes</focusLast>
        <underMouse>no</underMouse>
        <focusDelay>200</focusDelay>
        <raiseOnFocus>no</raiseOnFocus>
      </focus>
      <placement>
        <policy>Smart</policy>
      </placement>
      <theme>
        <name>Clearlooks</name>
        <cornerRadius>0</cornerRadius>
      </theme>
      <desktops>
        <number>9</number>
        <names>
          <name>1</name>
          <name>2</name>
          <name>3</name>
          <name>4</name>
          <name>5</name>
          <name>6</name>
          <name>7</name>
          <name>8</name>
          <name>9</name>
        </names>
      </desktops>
      <resize>
        <drawContents>yes</drawContents>
        <popupShow>Always</popupShow>
        <popupPosition>Center</popupPosition>
        <popupStacking>Above</popupStacking>
      </resize>
      <margins>
        <top>0</top>
        <bottom>0</bottom>
        <left>0</left>
        <right>0</right>
      </margins>
      <dock>
        <position>TopLeft</position>
        <floatingX>0</floatingX>
        <floatingY>0</floatingY>
        <noStrut>no</noStrut>
        <stacking>Above</stacking>
        <autoHide>no</autoHide>
        <hideDelay>300</hideDelay>
        <showDelay>300</showDelay>
        <moveButton>Middle</moveButton>
      </dock>
      <keyboard>
        <keybind key="A-Return">
          <action name="Execute"><command>alacritty</command></action>
        </keybind>
        <keybind key="A-space">
          <action name="Execute"><command>rofi -show drun</command></action>
        </keybind>
        <keybind key="A-q">
          <action name="Close"/>
        </keybind>
        <keybind key="A-f">
          <action name="ToggleFullscreen"/>
        </keybind>
        <keybind key="A-t">
          <action name="ToggleMaximizeFull"/>
        </keybind>
        <keybind key="A-s">
          <action name="Execute"><command>maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png</command></action>
        </keybind>
        <keybind key="A-S-s">
          <action name="Execute"><command>maim -s ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png</command></action>
        </keybind>
        <keybind key="Print">
          <action name="Execute"><command>maim ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png</command></action>
        </keybind>
        <keybind key="A-h">
          <action name="MoveToEdgeWest"/>
        </keybind>
        <keybind key="A-l">
          <action name="MoveToEdgeEast"/>
        </keybind>
        <keybind key="A-S-h">
          <action name="MoveToEdgeSouthWest"/>
        </keybind>
        <keybind key="A-S-l">
          <action name="MoveToEdgeSouthEast"/>
        </keybind>
        <keybind key="A-Tab">
          <action name="NextWindow">
            <finalactions>
              <action name="Focus"/>
              <action name="Raise"/>
            </finalactions>
          </action>
        </keybind>
        <keybind key="A-S-Tab">
          <action name="PreviousWindow">
            <finalactions>
              <action name="Focus"/>
              <action name="Raise"/>
            </finalactions>
          </action>
        </keybind>
        <keybind key="A-1">
          <action name="GoToDesktop"><to>1</to></action>
        </keybind>
        <keybind key="A-2">
          <action name="GoToDesktop"><to>2</to></action>
        </keybind>
        <keybind key="A-3">
          <action name="GoToDesktop"><to>3</to></action>
        </keybind>
        <keybind key="A-4">
          <action name="GoToDesktop"><to>4</to></action>
        </keybind>
        <keybind key="A-5">
          <action name="GoToDesktop"><to>5</to></action>
        </keybind>
        <keybind key="A-S-1">
          <action name="SendToDesktop"><to>1</to></action>
          <action name="GoToDesktop"><to>1</to></action>
        </keybind>
        <keybind key="A-S-2">
          <action name="SendToDesktop"><to>2</to></action>
          <action name="GoToDesktop"><to>2</to></action>
        </keybind>
        <keybind key="A-S-3">
          <action name="SendToDesktop"><to>3</to></action>
          <action name="GoToDesktop"><to>3</to></action>
        </keybind>
        <keybind key="A-S-4">
          <action name="SendToDesktop"><to>4</to></action>
          <action name="GoToDesktop"><to>4</to></action>
        </keybind>
        <keybind key="A-S-5">
          <action name="SendToDesktop"><to>5</to></action>
          <action name="GoToDesktop"><to>5</to></action>
        </keybind>
        <keybind key="A-m">
          <action name="SendToDesktop"><to>9</to></action>
          <action name="GoToDesktop"><to>9</to></action>
        </keybind>
        <keybind key="A-S-m">
          <action name="GoToDesktop"><to>9</to></action>
        </keybind>
        <keybind key="A-S-q">
          <action name="Execute"><command>i3lock</command></action>
        </keybind>
        <keybind key="XF86AudioRaiseVolume">
          <action name="Execute"><command>pactl set-sink-volume @DEFAULT_SINK@ +5%</command></action>
        </keybind>
        <keybind key="XF86AudioLowerVolume">
          <action name="Execute"><command>pactl set-sink-volume @DEFAULT_SINK@ -5%</command></action>
        </keybind>
        <keybind key="XF86AudioMute">
          <action name="Execute"><command>pactl set-sink-mute @DEFAULT_SINK@ toggle</command></action>
        </keybind>
        <keybind key="XF86AudioPlay">
          <action name="Execute"><command>playerctl play-pause</command></action>
        </keybind>
        <keybind key="XF86AudioNext">
          <action name="Execute"><command>playerctl next</command></action>
        </keybind>
        <keybind key="XF86AudioPrev">
          <action name="Execute"><command>playerctl previous</command></action>
        </keybind>
      </keyboard>
      <mouse>
        <context name="Root">
          <mousebind button="Right" action="Press">
            <action name="ShowMenu"><menu>root-menu</menu></action>
          </mousebind>
        </context>
        <context name="Client">
          <mousebind button="Left" action="Press">
            <action name="Focus"/>
            <action name="Raise"/>
          </mousebind>
          <mousebind button="Middle" action="Press">
            <action name="Focus"/>
            <action name="Raise"/>
          </mousebind>
          <mousebind button="Right" action="Press">
            <action name="Focus"/>
            <action name="Raise"/>
          </mousebind>
        </context>
      </mouse>
      <applications>
        <application class="Alacritty">
          <decor>yes</decor>
        </application>
      </applications>
    </openbox_config>
  '';

  xdg.configFile."openbox/menu.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <openbox_menu xmlns="http://openbox.org/3.4/menu">
      <menu id="root-menu" label="Openbox">
        <item label="Terminal">
          <action name="Execute"><command>alacritty</command></action>
        </item>
        <item label="Browser">
          <action name="Execute"><command>librewolf</command></action>
        </item>
        <item label="Rofi">
          <action name="Execute"><command>rofi -show drun</command></action>
        </item>
        <separator/>
        <item label="Reconfigure">
          <action name="Reconfigure"/>
        </item>
        <item label="Restart">
          <action name="Restart"/>
        </item>
        <separator/>
        <item label="Lock">
          <action name="Execute"><command>i3lock</command></action>
        </item>
        <item label="Exit">
          <action name="Exit"/>
        </item>
        <separator/>
        <item label="Log Out">
          <action name="Execute"><command>openbox --exit</command></action>
        </item>
      </menu>
    </openbox_menu>
  '';

  xdg.configFile."openbox/autostart".text = ''
    polybar main &
    picom --experimental-backends --inactive-opacity 0.88 &
    dunst &
    nm-applet &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    feh --bg-fill /run/current-system/sw/share/backgrounds/nixos/nix-wallpaper-nineish-dark-gray.png &
  '';

  xdg.configFile."polybar/config.ini".text = ''
    [colors]
    background = #1e1e2e
    foreground = #cdd6f4
    accent = #cba6f7

    [bar/main]
    width = 100%
    height = 28
    radius = 0
    background = ''${colors.background}
    foreground = ''${colors.foreground}
    line-size = 2
    border-top-size = 0
    border-bottom-size = 2
    border-color = #313244
    padding-left = 8
    padding-right = 8
    module-margin-left = 4
    module-margin-right = 4
    font-0 = "JetBrainsMono Nerd Font:size=12"
    modules-left = openbox
    modules-center = date
    modules-right = pulseaudio
    separator = |
    enable-ipc = true

    [module/openbox]
    type = internal/xworkspaces
    pin-workspaces = true
    label-active = %name%
    label-active-foreground = ''${colors.accent}
    label-active-underline = ''${colors.accent}
    label-occupied = %name%
    label-urgent = %name%
    label-empty = %name%
    label-empty-foreground = #585b70

    [module/date]
    type = internal/date
    interval = 30
    date = %a %b %d  %H:%M
    label = %date%

    [module/pulseaudio]
    type = internal/pulseaudio
    format-volume = V <label-volume>
    label-volume = %percentage%
    format-muted = V mute

    [module/network]
    type = internal/network
    interface = eth0
    format-connected = N <label-connected>
    label-connected = %local_ip%
    format-disconnected = N down

    [module/battery]
    type = internal/battery
    battery = BAT0
    adapter = AC0
    format-charging = B <label-charging>
    label-charging = %percentage%%
    format-discharging = B <label-discharging>
    label-discharging = %percentage%%
    format-full = B full
  '';
}

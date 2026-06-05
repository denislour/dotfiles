{ pkgs, ... }:

let
  modifier = "Alt";
in
{
  home.file = {
    ".config/openbox/rc.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <openbox_config xmlns="http://openbox.org/3.4/rc"
              xmlns:xi="http://www.w3.org/2001/XInclude">

        <resistance>
          <strength>10</strength>
          <screen_edge_strength>20</screen_edge_strength>
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
          <policy>UnderMouse</policy>
          <center>no</center>
          <monitor>Primary</monitor>
          <primaryMonitor>1</primaryMonitor>
        </placement>

        <theme>
          <name>Clearlooks</name>
          <titleLayout>NLIMC</titleLayout>
          <keepBorder>yes</keepBorder>
          <animateIconify>no</animateIconify>
          <font place="ActiveWindow">
            <name>sans-serif</name>
            <size>9</size>
            <bold>no</bold>
          </font>
          <font place="InactiveWindow">
            <name>sans-serif</name>
            <size>9</size>
            <bold>no</bold>
          </font>
          <font place="MenuHeader">
            <name>sans-serif</name>
            <size>9</size>
            <bold>yes</bold>
          </font>
          <font place="MenuItem">
            <name>sans-serif</name>
            <size>9</size>
            <bold>no</bold>
          </font>
          <font place="OnScreenDisplay">
            <name>sans-serif</name>
            <size>9</size>
            <bold>no</bold>
          </font>
        </theme>

        <desktops>
          <number>5</number>
          <firstdesk>1</firstdesk>
          <names>
            <name>1</name>
            <name>2</name>
            <name>3</name>
            <name>4</name>
            <name>5</name>
          </names>
        </desktops>

        <resize>
          <drawContents>yes</drawContents>
          <popupShow>Nonpixel</popupShow>
          <popupPosition>Center</popupPosition>
          <popupStacking>Above</popupStacking>
        </resize>

        <margins>
          <top>0</top>
          <bottom>0</bottom>
          <left>0</left>
          <right>0</right>
        </margins>

        <keyboard>
          <keybind key="${modifier}-Return">
            <action name="Execute"><command>${pkgs.ghostty}/bin/ghostty</command></action>
          </keybind>
          <keybind key="${modifier}-Space">
            <action name="Execute"><command>${pkgs.rofi}/bin/rofi -show drun</command></action>
          </keybind>
          <keybind key="${modifier}-Shift-d">
            <action name="Execute"><command>${pkgs.rofi}/bin/rofi -show run</command></action>
          </keybind>
          <keybind key="${modifier}-Tab">
            <action name="Execute"><command>${pkgs.rofi}/bin/rofi -show window</command></action>
          </keybind>

          <keybind key="${modifier}-q">
            <action name="Close"/>
          </keybind>
          <keybind key="${modifier}-f">
            <action name="ToggleFullscreen"/>
          </keybind>

          <!-- Focus -->
          <keybind key="${modifier}-h">
            <action name="FocusTo"><direction>west</direction></action>
            <action name="Raise"/>
          </keybind>
          <keybind key="${modifier}-j">
            <action name="FocusTo"><direction>south</direction></action>
            <action name="Raise"/>
          </keybind>
          <keybind key="${modifier}-k">
            <action name="FocusTo"><direction>north</direction></action>
            <action name="Raise"/>
          </keybind>
          <keybind key="${modifier}-l">
            <action name="FocusTo"><direction>east</direction></action>
            <action name="Raise"/>
          </keybind>

          <!-- Move window to edge -->
          <keybind key="${modifier}-Shift-h">
            <action name="MoveToEdge"><direction>west</direction></action>
          </keybind>
          <keybind key="${modifier}-Shift-j">
            <action name="MoveToEdge"><direction>south</direction></action>
          </keybind>
          <keybind key="${modifier}-Shift-k">
            <action name="MoveToEdge"><direction>north</direction></action>
          </keybind>
          <keybind key="${modifier}-Shift-l">
            <action name="MoveToEdge"><direction>east</direction></action>
          </keybind>

          <!-- Workspaces -->
          <keybind key="${modifier}-1">
            <action name="GoToDesktop"><to>1</to></action>
          </keybind>
          <keybind key="${modifier}-2">
            <action name="GoToDesktop"><to>2</to></action>
          </keybind>
          <keybind key="${modifier}-3">
            <action name="GoToDesktop"><to>3</to></action>
          </keybind>
          <keybind key="${modifier}-4">
            <action name="GoToDesktop"><to>4</to></action>
          </keybind>
          <keybind key="${modifier}-5">
            <action name="GoToDesktop"><to>5</to></action>
          </keybind>

          <!-- Move to workspace -->
          <keybind key="${modifier}-Shift-1">
            <action name="SendToDesktop"><to>1</to></action>
            <action name="GoToDesktop"><to>1</to></action>
          </keybind>
          <keybind key="${modifier}-Shift-2">
            <action name="SendToDesktop"><to>2</to></action>
            <action name="GoToDesktop"><to>2</to></action>
          </keybind>
          <keybind key="${modifier}-Shift-3">
            <action name="SendToDesktop"><to>3</to></action>
            <action name="GoToDesktop"><to>3</to></action>
          </keybind>
          <keybind key="${modifier}-Shift-4">
            <action name="SendToDesktop"><to>4</to></action>
            <action name="GoToDesktop"><to>4</to></action>
          </keybind>
          <keybind key="${modifier}-Shift-5">
            <action name="SendToDesktop"><to>5</to></action>
            <action name="GoToDesktop"><to>5</to></action>
          </keybind>

          <!-- Screenshot -->
          <keybind key="Print">
            <action name="Execute"><command>${pkgs.maim}/bin/maim ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png</command></action>
          </keybind>
          <keybind key="Shift-Print">
            <action name="Execute"><command>${pkgs.maim}/bin/maim -s ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png</command></action>
          </keybind>
        </keyboard>

        <mouse>
          <context name="Root">
            <mousebind button="Right" action="Press">
              <action name="ShowMenu"><menu>root-menu</menu></action>
            </mousebind>
          </context>

          <context name="Client">
            <mousebind button="Left" action="Drag">
              <action name="Move"/>
            </mousebind>
            <mousebind button="Middle" action="Drag">
              <action name="Resize"/>
            </mousebind>
            <mousebind button="Left" action="DoubleClick">
              <action name="ToggleMaximize"/>
            </mousebind>
          </context>
        </mouse>

      </openbox_config>
    '';

    ".config/openbox/menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <openbox_menu xmlns="http://openbox.org/3.4/menu">
        <menu id="root-menu" label="Openbox">
          <item label="Terminal">
            <action name="Execute"><command>${pkgs.ghostty}/bin/ghostty</command></action>
          </item>
          <item label="Browser">
            <action name="Execute"><command>${pkgs.brave}/bin/brave</command></action>
          </item>
          <separator/>
          <item label="Rofi">
            <action name="Execute"><command>${pkgs.rofi}/bin/rofi -show drun</command></action>
          </item>
          <separator/>
          <item label="Reconfigure">
            <action name="Reconfigure"/>
          </item>
          <item label="Restart">
            <action name="Restart"/>
          </item>
          <separator/>
          <item label="Exit">
            <action name="Exit"/>
          </item>
        </menu>
      </openbox_menu>
    '';

    ".config/openbox/autostart".text = ''
      #!/usr/bin/env bash

      # Compositor
      ${pkgs.picom}/bin/picom -b &

      # Wallpaper
      ${pkgs.feh}/bin/feh --bg-scale ${../../system/wallpapers/default.jpg} &

      # Notification daemon
      ${pkgs.dunst}/bin/dunst &

      # Redshift
      ${pkgs.redshift}/bin/redshift -t 5500:4500 -l 10.8:106.7 &

      # Bar
      # ${pkgs.tint2}/bin/tint2 &
    '';
  };

  home.file.".config/openbox/autostart".executable = true;
}

{ pkgs, ... }:

let
  openboxRc = pkgs.writeText "rc.xml" ''
    <?xml version="1.0"?>
    <openbox_config xmlns="http://openbox.org/3.4/rc">
      <resistance>
        <strength>10</strength>
        <corner_grab_area>4</corner_grab_area>
      </resistance>
      <focus>
        <focusNew>yes</focusNew>
        <focusLast>yes</focusLast>
        <followMouse>no</followMouse>
        <focusDelay>250</focusDelay>
      </focus>
      <placement>
        <policy>UnderMouse</policy>
      </placement>
      <desktops>
        <number>5</number>
        <names>
          <name>1</name>
          <name>2</name>
          <name>3</name>
          <name>4</name>
          <name>5</name>
        </names>
      </desktops>
      <keyboard>
        <keybind key="A-Return">
          <action name="Execute"><command>ghostty</command></action>
        </keybind>
        <keybind key="A-F4">
          <action name="Close"/>
        </keybind>
        <keybind key="W-d">
          <action name="Execute"><command>rofi -show drun</command></action>
        </keybind>
        <keybind key="W-f">
          <action name="ToggleFullscreen"/>
        </keybind>
        <keybind key="A-Tab">
          <action name="NextWindow"/>
        </keybind>
        <keybind key="S-A-Tab">
          <action name="PreviousWindow"/>
        </keybind>
        <keybind key="W-1">
          <action name="Desktop"><desktop>1</desktop></action>
        </keybind>
        <keybind key="W-2">
          <action name="Desktop"><desktop>2</desktop></action>
        </keybind>
        <keybind key="W-3">
          <action name="Desktop"><desktop>3</desktop></action>
        </keybind>
        <keybind key="W-4">
          <action name="Desktop"><desktop>4</desktop></action>
        </keybind>
        <keybind key="W-5">
          <action name="Desktop"><desktop>5</desktop></action>
        </keybind>
        <keybind key="Print">
          <action name="Execute"><command>maim ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png</command></action>
        </keybind>
        <keybind key="S-Print">
          <action name="Execute"><command>maim -s ~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png</command></action>
        </keybind>
      </keyboard>
      <applications>
        <application class="Rofi">
          <decor>no</decor>
          <position><x>center</x><y>center</y></position>
        </application>
        <application class="ghostty">
          <decor>yes</decor>
        </application>
      </applications>
    </openbox_config>
  '';

  autostart = pkgs.writeShellScript "openbox-autostart" ''
    ${pkgs.picom}/bin/picom -b &
    ${pkgs.feh}/bin/feh --bg-scale ${../../system/wallpapers/default.jpg} &
  '';
in
{
  xdg.configFile."openbox/rc.xml".source = openboxRc;
  xdg.configFile."openbox/autostart".source = autostart;
}

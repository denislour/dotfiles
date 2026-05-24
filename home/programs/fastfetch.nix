{ ... }: let
  dogeLogo = ./doge.txt;
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "file-raw";
        source = "${dogeLogo}";
        padding = { left = 2; };
      };
      display = {
        separator = " → ";
        color = "blue";
      };
      modules = [
    {
      type = "title";
      key = "   user";
      format = "{user-name}";
      keyColor = "cyan";
    }
    {
      type = "title";
      key = "  󰇅 host";
      format = "{host-name}";
      keyColor = "green";
    }
    "separator"
    {
      type = "os";
      key = "   distro";
      keyColor = "blue";
    }
    {
      type = "kernel";
      key = "   kernel";
      keyColor = "yellow";
    }
    {
      type = "uptime";
      key = "  󰅐 uptime";
      keyColor = "magenta";
    }
    {
      type = "packages";
      key = "  󰏗 packages";
      keyColor = "cyan";
    }
    {
      type = "shell";
      key = "   shell";
      keyColor = "green";
    }
    {
      type = "wm";
      key = "  󰧨 wm";
      keyColor = "yellow";
    }
    {
      type = "terminal";
      key = "   term";
      keyColor = "blue";
    }
    "separator"
    {
      type = "cpu";
      key = "  󰍛 cpu";
      keyColor = "magenta";
    }
    {
      type = "gpu";
      key = "  󰢮 gpu";
      keyColor = "cyan";
    }
    {
      type = "memory";
      key = "   memory";
      keyColor = "green";
    }
    {
      type = "disk";
      key = "  󰉉 disk";
      keyColor = "yellow";
    }
    "separator"
    {
      type = "colors";
      symbol = "circle";
    }
  ];
    };
  };
}

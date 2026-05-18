{ pkgs, ... }:

{
  home.packages = [ pkgs.pi-coding-agent ];

  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    defaultProvider = "deepseek";
  };
}

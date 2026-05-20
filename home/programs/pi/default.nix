{ pkgs, config, ... }:

let
  piWrapper = pkgs.writeShellScriptBin "pi" ''
    export DEEPSEEK_API_KEY=$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")
    export BRAVE_SEARCH_API_KEY=$(cat /run/secrets/brave_search_api_key 2>/dev/null || echo "")
    exec ${pkgs.pi-coding-agent}/bin/pi "$@"
  '';
in
{
  home.packages = [ piWrapper ];

  home.file.".pi/agent/settings.json".text = builtins.toJSON (import ./agent/settings.nix);
  home.file.".pi/agent/models.json".text = builtins.toJSON (import ./agent/models.nix);
  home.file.".pi/agent/caveman.json".text = builtins.toJSON (import ./agent/caveman.nix);
  home.file.".pi/agent/themes/arabica.json".source = ./agent/themes/arabica.json;
  home.file.".pi/agent/themes/robusta.json".source = ./agent/themes/robusta.json;
  home.file.".pi/agent/skills/web-search/SKILL.md".source = ./agent/skills/web-search/SKILL.md;
  home.file.".pi/agent/skills/nix-style/SKILL.md".source = ./agent/skills/nix-style/SKILL.md;
}

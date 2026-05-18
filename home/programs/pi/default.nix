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

  home.file.".pi/agent/settings.json".source = ./settings.json;
  home.file.".pi/agent/models.json".source = ./models.json;
  home.file.".pi/skills/web-search/SKILL.md".source = ./skills/web-search/SKILL.md;
}

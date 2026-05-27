{ pkgs, lib, config, ... }:

let
  piWrapper = pkgs.writeShellScriptBin "pi" ''
    export NPM_CONFIG_PREFIX="${config.home.homeDirectory}/.pi/npm"
    export PATH="${pkgs.nodejs}/bin:${config.home.homeDirectory}/.pi/npm/bin:$PATH"
    export DEEPSEEK_API_KEY=$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")
    export BRAVE_SEARCH_API_KEY=$(cat /run/secrets/brave_search_api_key 2>/dev/null || echo "")
    exec ${pkgs.pi-coding-agent}/bin/pi "$@"
  '';

  agentSettings = builtins.toJSON (import ./agent/settings.nix);
  agentModels = builtins.toJSON (import ./agent/models.nix);

in
{
  home.packages = [ piWrapper ];

  home.file.".pi/npm/.keep".text = "";

  home.file.".pi/agent/settings.json".text = agentSettings;
  home.file.".pi/agent/models.json".text = agentModels;
  home.file.".pi/agent/themes/arabica.json".source = ./agent/themes/arabica.json;
  home.file.".pi/agent/themes/robusta.json".source = ./agent/themes/robusta.json;
  home.file.".pi/agent/skills/web-search/SKILL.md".source = ./agent/skills/web-search/SKILL.md;
  home.file.".pi/agent/skills/nix-style/SKILL.md".source = ./agent/skills/nix-style/SKILL.md;
  home.file.".pi/agent/skills/caveman/SKILL.md".source = ./agent/skills/caveman/SKILL.md;
  home.file.".pi/agent/skills/pi-extensions/SKILL.md".source = ./agent/skills/pi-extensions/SKILL.md;
  home.file.".pi/agent/extensions/caveman/index.ts".source = ./agent/extensions/caveman/index.ts;
  home.file.".pi/agent/extensions/ds-balance/index.ts".source = ./agent/extensions/ds-balance/index.ts;

  home.activation.ensureDesignSystemsSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    designs="${config.home.homeDirectory}/.pi/designs"
    link="${config.home.homeDirectory}/.pi/agent/skills/design-systems"
    if [ -d "$designs" ]; then
      mkdir -p "$(dirname "$link")"
      ln -sfn "$designs" "$link"
    fi
  '';
}

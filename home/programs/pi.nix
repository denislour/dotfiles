{ pkgs, config, ... }:

let
  piWrapper = pkgs.writeShellScriptBin "pi" ''
    export DEEPSEEK_API_KEY=$(cat /run/secrets/deepseek_api_key 2>/dev/null || echo "")
    export BRAVE_SEARCH_API_KEY=$(cat /run/secrets/brave_search_api_key 2>/dev/null || echo "")
    exec ${pkgs.pi-coding-agent}/bin/pi "$@"
  '';

  piAgentsDir = "${config.home.homeDirectory}/.agents/skills";
in
{
  home.packages = [ piWrapper ];

  # Deploy web-search skill
  home.file.".agents/skills/web-search/SKILL.md".source = ../../.agents/skills/web-search/SKILL.md;

  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    defaultProvider = "deepseek";
    defaultModel = "deepseek-v4-flash";
    skills = [ piAgentsDir ];
  };

  home.file.".pi/agent/models.json".text = builtins.toJSON {
    providers.deepseek = {
      baseUrl = "https://api.deepseek.com";
      api = "openai-completions";
      apiKey = "$DEEPSEEK_API_KEY";
      models = [
        {
          id = "deepseek-v4-pro";
          name = "DeepSeek V4 Pro";
          contextWindow = 1000000;
          maxTokens = 384000;
          input = [ "text" ];
          reasoning = true;
          cost = {
            input = 1.74;
            output = 3.48;
            cacheRead = 0.145;
            cacheWrite = 0;
          };
          requiresReasoningContentOnAssistantMessages = true;
          thinkingFormat = "deepseek";
          reasoningEffortMap = {
            minimal = "high";
            low = "high";
            medium = "high";
            high = "high";
            xhigh = "max";
          };
        }
        {
          id = "deepseek-v4-flash";
          name = "DeepSeek V4 Flash";
          contextWindow = 1000000;
          maxTokens = 384000;
          input = [ "text" ];
          reasoning = true;
          cost = {
            input = 0.14;
            output = 0.28;
            cacheRead = 0.028;
            cacheWrite = 0;
          };
          requiresReasoningContentOnAssistantMessages = true;
          thinkingFormat = "deepseek";
          reasoningEffortMap = {
            minimal = "high";
            low = "high";
            medium = "high";
            high = "high";
            xhigh = "max";
          };
        }
      ];
    };
  };
}

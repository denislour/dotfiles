let
  baseConfig = {
    contextWindow = 1000000;
    maxTokens = 384000;
    input = [ "text" ];
    reasoning = true;
    requiresReasoningContentOnAssistantMessages = true;
    thinkingFormat = "deepseek";
    reasoningEffortMap = {
      minimal = "low";
      low = "low";
      medium = "medium";
      high = "high";
      xhigh = "max";
    };
  };
in
{
  providers.deepseek = {
    baseUrl = "https://api.deepseek.com";
    api = "openai-completions";
    apiKey = "$DEEPSEEK_API_KEY";
    models = [
      (baseConfig // {
        id = "deepseek-v4-pro";
        name = "DeepSeek V4 Pro";
        cost = {
          input = 1.74;
          output = 3.48;
          cacheRead = 0.145;
          cacheWrite = 0;
        };
      })
      (baseConfig // {
        id = "deepseek-v4-flash";
        name = "DeepSeek V4 Flash";
        cost = {
          input = 0.14;
          output = 0.28;
          cacheRead = 0.028;
          cacheWrite = 0;
        };
      })
    ];
  };
}

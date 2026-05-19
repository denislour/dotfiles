{ ... }:

{
  home.file.".config/zed/settings.json" = {
    text = builtins.toJSON {
      assistant = {
        version = "2";
        default_model = {
          provider = "deepseek";
          model = "deepseek-v4-flash";
        };
        button = true;
      };
      language_models = {
        deepseek = {
          api_url = "https://api.deepseek.com";
          available_models = [
            {
              name = "deepseek-v4-flash";
              display_name = "DeepSeek V4 Flash";
              max_tokens = 1000000;
              max_output_tokens = 384000;
            }
            {
              name = "deepseek-v4-pro";
              display_name = "DeepSeek V4 Pro";
              max_tokens = 1000000;
              max_output_tokens = 384000;
            }
          ];
        };
      };
    };
  };
}

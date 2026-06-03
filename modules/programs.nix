{
  flake.modules.homeManager.programs = {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        style = "auto";
        theme = "catppuccin-mocha";
      };
    };

    programs.bottom = {
      enable = true;
      settings.flags = {
        color = "default";
        group = true;
        mem_as_value = false;
        tree = false;
      };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
        light = false;
        syntax-theme = "catppuccin-mocha";
      };
    };

    programs.eza = {
      enable = true;
      icons = "always";
      colors = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    programs.fd = {
      enable = true;
      hidden = true;
      ignores = [ ".git" ];
      extraOptions = [ ];
    };

    programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=150"
        "--smart-case"
        "--hidden"
        "--glob=!.git"
      ];
    };

    programs.yazi = {
      enable = true;
      shellWrapperName = "yy";

      settings = {
        manager = {
          show_hidden = true;
          sort_by = "natural";
          sort_dir_first = true;
          linemode = "none";
        };
        preview = {
          tab_size = 4;
          image_filter = "lanczos3";
        };
      };

      keymap.manager.prepend_keymap = [
        { on = "g n"; run = "linemode \"size\""; desc = "Show file sizes"; }
        { on = "g m"; run = "linemode \"mtime\""; desc = "Show modification time"; }
        { on = "g p"; run = "linemode \"permissions\""; desc = "Show permissions"; }
      ];
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Lektor";
          email = "denislour@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    programs.lazygit.enable = true;
  };
}

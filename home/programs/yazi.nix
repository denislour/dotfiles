{
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

    keymap = {
      manager.prepend_keymap = [
        { on = "g n"; run = "linemode \"size\""; desc = "Show file sizes"; }
        { on = "g m"; run = "linemode \"mtime\""; desc = "Show modification time"; }
        { on = "g p"; run = "linemode \"permissions\""; desc = "Show permissions"; }
      ];
    };
  };
}

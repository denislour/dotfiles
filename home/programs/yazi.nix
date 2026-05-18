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
  };
}

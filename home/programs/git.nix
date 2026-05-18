{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lektor";
        email = "Lektor@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}

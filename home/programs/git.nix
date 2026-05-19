{
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
}

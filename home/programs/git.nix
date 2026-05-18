{ pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home.activation.setGitUser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.git}/bin:$PATH"
    git config --global user.name "$(cat /run/secrets/git_name 2>/dev/null || echo Lektor)"
    git config --global user.email "$(cat /run/secrets/git_email 2>/dev/null || echo lektor@users.noreply.github.com)"
  '';
}

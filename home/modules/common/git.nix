{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}

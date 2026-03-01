{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      gs = "git status -sb";
    };
  };

  programs.starship.enable = true;
}

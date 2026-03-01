{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = {
      cc = "claude --dangerously-skip-permissions";
      ls = "eza --icons --color=always --group-directories-first";
      ll = "eza -l --icons --color=always --group-directories-first";
      la = "eza -la --icons --color=always --group-directories-first";
      sesh = "tmux attach || exec tmux new-session && exit;";
      gs = "git status -sb";
      ta = "tmux attach || tmux new-session";
      hmup = "$HOME/Work/nix-config/scripts/hmup";
    };
  };

  programs.starship.enable = true;
}

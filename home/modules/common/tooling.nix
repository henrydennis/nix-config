{ ... }:
{
  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    jq.enable = true;

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Henry Dennis";
          email = "github@henrydennis.co.uk";
        };
      };
    };

    ripgrep.enable = true;

    sesh = {
      enable = true;
      enableTmuxIntegration = true;
    };

    tmux = {
      enable = true;
      mouse = true;
      clock24 = true;
      keyMode = "vi";
    };

    uv.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

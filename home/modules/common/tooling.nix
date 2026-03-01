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
        git_protocol = "https";
        editor = "";
        prompt = "enabled";
        prefer_editor_prompt = "disabled";
        pager = "";
        aliases = {
          co = "pr checkout";
        };
        http_unix_socket = "";
        browser = "";
        color_labels = "disabled";
        accessible_colors = "disabled";
        accessible_prompter = "disabled";
        spinner = "enabled";
      };
    };

    jq.enable = true;

    jujutsu = {
      enable = true;
      settings = {
        "$schema" = "https://jj-vcs.github.io/jj/latest/config-schema.json";
        user = {
          name = "Henry Dennis";
          email = "github@henrydennis.co.uk";
        };
      };
    };

    ripgrep.enable = true;

    sesh = {
      enable = true;
      enableTmuxIntegration = false;
    };

    tmux = {
      enable = true;
      mouse = true;
    };

    uv.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

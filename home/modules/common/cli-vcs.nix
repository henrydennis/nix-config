{ ... }:
{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
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
  };
}

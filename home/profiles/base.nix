{ ... }:
{
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.git = {
    ignores = [
      "**/.claude/settings.local.json"
      "**/CLAUDE.local.md"
    ];

    settings = {
      user.name = "Henry Dennis";
      user.email = "github@henrydennis.co.uk";
      gitbutler = {
        aiOpenAIKeyOption = "butlerAPI";
        aiModelProvider = "lmstudio";
      };
    };
  };
}

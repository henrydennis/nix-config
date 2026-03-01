{ ... }:
{
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.git = {
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

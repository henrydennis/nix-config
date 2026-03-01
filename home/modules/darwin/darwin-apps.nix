{ ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        terminal.shell.program = "zsh";
      };
    };

    aerospace = {
      enable = true;
      launchd.enable = true;
      userSettings = {
        mode.main.binding = {
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";
        };
      };
    };
  };
}

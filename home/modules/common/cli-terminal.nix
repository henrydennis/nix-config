{ ... }:
{
  programs = {
    sesh = {
      enable = true;
      enableTmuxIntegration = false;
    };

    tmux = {
      enable = true;
      mouse = true;
    };
  };
}

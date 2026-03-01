{ ... }:
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    bat.enable = true;
    fd.enable = true;
  };
}

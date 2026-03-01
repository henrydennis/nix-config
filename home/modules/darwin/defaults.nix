{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pinentry_mac
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };
}

{ inputs }:
{
  username,
  hostname,
  system,
  stateVersion ? "25.11",
  profileModules ? [ ],
  hostModules ? [ ],
  extraModules ? [ ],
}:
let
  inherit (inputs) home-manager nixpkgs;

  overlay = import ../overlays/default.nix;

  pkgs = import nixpkgs {
    inherit system;
    overlays = [ overlay ];
    config.allowUnfree = true;
  };

  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  osModules =
    if isDarwin then
      [
        ../home/modules/darwin/security-pinentry.nix
        ../home/modules/darwin/window-management.nix
      ]
    else
      [ ../home/modules/linux/xdg-user-dirs.nix ];

  homeDirectory =
    if isDarwin then
      "/Users/${username}"
    else
      "/home/${username}";
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = {
    inherit hostname username;
  };

  modules =
    [
      # Shared session defaults
      ../home/modules/common/session-defaults.nix

      # Interactive shell and editor
      ../home/modules/common/shell-interactive.nix
      ../home/modules/common/editor-neovim.nix

      # Development runtimes and version control
      ../home/modules/common/runtime-languages.nix
      ../home/modules/common/cli-vcs.nix

      # Command-line workflow and utilities
      ../home/modules/common/cli-shell-productivity.nix
      ../home/modules/common/cli-terminal.nix
      ../home/modules/common/cli-utils.nix
      {
        home = {
          inherit username homeDirectory stateVersion;
        };

        programs.home-manager.enable = true;
      }
    ]
    ++ osModules
    ++ profileModules
    ++ hostModules
    ++ extraModules;
}

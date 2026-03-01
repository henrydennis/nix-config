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
        ../home/modules/darwin/defaults.nix
        ../home/modules/darwin/darwin-apps.nix
      ]
    else
      [ ../home/modules/linux/xdg.nix ];

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
      ../home/modules/common/git.nix
      ../home/modules/common/shell.nix
      ../home/modules/common/editor.nix
      ../home/modules/common/tooling.nix
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

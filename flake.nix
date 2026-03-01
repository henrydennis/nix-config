{
  description = "Home Manager flake for macOS and Linux hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkHome = import ./lib/mk-home.nix { inherit inputs; };

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays.default = import ./overlays/default.nix;

      packages = forAllSystems (system: import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; });

      homeModules = {
        profile-base = import ./home/profiles/base.nix;

        common-session-defaults = import ./home/modules/common/session-defaults.nix;
        common-shell-interactive = import ./home/modules/common/shell-interactive.nix;
        common-editor-neovim = import ./home/modules/common/editor-neovim.nix;
        common-runtime-languages = import ./home/modules/common/runtime-languages.nix;
        common-git-core = import ./home/modules/common/git-core.nix;
        common-cli-vcs = import ./home/modules/common/cli-vcs.nix;
        common-cli-shell-productivity = import ./home/modules/common/cli-shell-productivity.nix;
        common-cli-terminal = import ./home/modules/common/cli-terminal.nix;
        common-cli-utils = import ./home/modules/common/cli-utils.nix;

        darwin-security-pinentry = import ./home/modules/darwin/security-pinentry.nix;
        darwin-window-management = import ./home/modules/darwin/window-management.nix;
        linux-xdg-user-dirs = import ./home/modules/linux/xdg-user-dirs.nix;
      };

      homeConfigurations = {
        "henrydennis@H-MB-PRO" = mkHome {
          username = "henrydennis";
          hostname = "H-MB-PRO";
          system = "aarch64-darwin";
          profileModules = [ ./home/profiles/base.nix ];
          hostModules = [ ./home/hosts/henrydennis-H-MB-PRO.nix ];
        };

        "henry@example-linux" = mkHome {
          username = "henry";
          hostname = "example-linux";
          system = "x86_64-linux";
          profileModules = [ ./home/profiles/base.nix ];
          hostModules = [ ./home/hosts/henry-example-linux.nix ];
        };
      };
    };
}

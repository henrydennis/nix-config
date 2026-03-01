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
        common-git = import ./home/modules/common/git.nix;
        common-shell = import ./home/modules/common/shell.nix;
        common-editor = import ./home/modules/common/editor.nix;
        darwin-defaults = import ./home/modules/darwin/defaults.nix;
        linux-xdg = import ./home/modules/linux/xdg.nix;
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

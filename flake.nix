{
  description = "Home Manager Configuration";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    trusted-users = "jwm";
    max-jobs = 2;
    max-substitution-jobs = 2;
    cores = 5;
  };
   
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher = {
      url = "github:mintylotl/prismcrack";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };
  };
  outputs = { nixpkgs, home-manager, prismlauncher, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      prism = prismlauncher;

    in {
      nixosConfigurations = {
        cabbage = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jwm = import ./home.nix;
              home-manager.backupFileExtension = "old";
            }
          ];
          specialArgs = { inherit prism; };
        };
      };
    };
}

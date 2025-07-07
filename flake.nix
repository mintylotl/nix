{
  description = "NixOS Flake Configuration";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    trusted-users = [ "root" "panda" ];
    max-jobs = 1;
    max-substitution-jobs = 1;
    cores = 1;
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs_unstable = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs?ref=nixos-25.05"; };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prism = {
      url = "github:mintylotl/prismcrack";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umuProton = {
      url =
        "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
    };
  };

  outputs = { self, nixpkgs, nixpkgs_unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs_unst = import nixpkgs_unstable {
        system = system;
        config.allowUnfree = true;
      };

      packages.x86_64-linux = nixpkgs_unstable.legacyPackages.${system};

    in {
      nixosConfigurations = {
        banana = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            home-manager.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.panda = import ./home.nix;
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit pkgs_unst;
          };
        };
      };
    };
}

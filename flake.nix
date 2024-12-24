{
  description = "NixOS Flake Configuration";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    trusted-users = "jwm";
    max-jobs = 1;
    max-substitution-jobs = 1;
    cores = 5;
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs_unstable = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs?ref=nixos-24.11"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prism = {
      url = "github:mintylotl/prismcrack";
      inputs.nixpkgs.follows = "nixpkgs_unstable";
    };

    umuProton = {
      url =
        "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
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

      packages.${system} = nixpkgs_unstable.legacyPackages.${system};

    in {
      nixosConfigurations = {
        cabbage = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            home-manager.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jwm = import ./home.nix;
              home-manager.users.gameboy = import ./home_gb.nix;
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

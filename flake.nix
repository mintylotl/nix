{
  description = "Home Manager Configuration";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    trusted-users = "jwm";
    max-jobs = 1;
    max-substitution-jobs = 1;
    cores = 5;
  };
   
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prism = {
      url = "github:mintylotl/prismcrack";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umuProton = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@ { 
      nixpkgs,
      home-manager,
      ... 
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in {
      nixosConfigurations = {
	inherit system;
	inherit pkgs;

        cabbage = nixpkgs.lib.nixosSystem {
	  modules = [
            ./configuration.nix
            home-manager.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jwm = import ./home.nix;
              home-manager.backupFileExtension = "old";
            }
          ];
        };
      };
    };
}

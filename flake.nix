{
  description = "Home Manager Configuration";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    trusted-users = "jwm";
    max-jobs = 2;
    max-substitution-jobs = 3;
    cores = 4;
  };
   
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-lsg  = {
      url = "github:nixos/nixpkgs/ecd9092716186bef474abbd28b838b9eb75046ca";
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

  outputs = { 
      self,
      nixpkgs,
      nixpkgs-lsg,
      home-manager,
      ... 
    }
    @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-lsg = nixpkgs-lsg.legacyPackages.${system};
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
            }
          ];
	  specialArgs = {
	    inherit inputs;
	    inherit pkgs-lsg;
	  };
        };
      };
    };
}

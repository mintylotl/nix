{
  description = "NixOS Flake Configuration";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    trusted-users = "jwm";
    max-jobs = 1;
    max-substitution-jobs = 1;
    cores = 5;

    #extra-substituters =
    #  [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
    #extra-trusted-public-keys = [
    #  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #  "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
    #];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs_unstable = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs?ref=nixos-24.11"; };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prism = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
      inputs.flake-compat.follows = "";
    };

    umuProton = {
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs_unstable";
      #"github:Open-Wine-Components/umu-launcher/59a82ea8cd284c7535bc06b8f6156abb7da96f6a?dir=packaging/nix";
    };

    musicBee = {
      url = "github:NixOS/nixpkgs/030ba1976b7c0e1a67d9716b17308ccdab5b381e";
    };

    Hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs_unstable, home-manager, prism, musicBee
    , ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs_unst = import nixpkgs_unstable {
        system = system;
        config.allowUnfree = true;
      };
      pkgs_old = musicBee.legacyPackages.${system};
      packages.x86_64-linux = nixpkgs_unstable.legacyPackages.${system};

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
            inherit prism;
            inherit pkgs_unst;
            inherit pkgs_old;
            inherit musicBee;
          };
        };
      };
    };
}

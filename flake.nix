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
    #nixpkgs_unstable = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
    #nixpkgs = { url = "github:nixos/nixpkgs?ref=nixos-24.11"; };

    nixpkgs_unstable = { url = "github:NixOS/nixpkgs/d74a2335ac9c"; };
    nixpkgs = { url = "github:NixOS/nixpkgs/c618e28f7025"; };

    home-manager = { url = "github:nix-community/home-manager?ref=master"; };

    prism = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
      inputs.flake-compat.follows = "";
    };

    umuProton = {
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      #"github:Open-Wine-Components/umu-launcher/59a82ea8cd284c7535bc06b8f6156abb7da96f6a?dir=packaging/nix";
    };

    musicBee = {
      url = "github:NixOS/nixpkgs/030ba1976b7c0e1a67d9716b17308ccdab5b381e";
    };

    Hyprland = { url = "github:hyprwm/hyprland"; };
  };

  outputs = { self, nixpkgs, Hyprland, nixpkgs_unstable, home-manager, prism
    , musicBee, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs_old = musicBee.legacyPackages.${system};
      pkgs_unst = import nixpkgs_unstable {
        inherit system;
        config.allowUnfree = true;
      };

      packages.x86_64-linux = nixpkgs_unstable.legacyPackages.${system};

    in {
      nixosConfigurations = {
        cabbage = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jwm = import ./home.nix;
              home-manager.users.gameboy = import ./home_gb.nix;

              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit Hyprland;
            inherit prism;
            inherit pkgs_unst;
            inherit pkgs_old;
            inherit musicBee;
          };
        };
      };
    };
}

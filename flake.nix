{
  description = "NixOS Flake Configuration";

  nixConfig = {
    experimental-features = "nix-command flakes";
    trusted-users = "jwm";
    max-jobs = 3;
    max-substitution-jobs = 1;
    cores = 5;

    extra-substituters = [
      "https://cache.nixos.org"

      "https://nix-community.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://hyprland.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs_unstable = {
      url = "github:nixos/nixpkgs?ref=master";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs?ref=nixos-26.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
    };

    prism = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
      inputs.nixpkgs.follows = "nixpkgs_unstable";
    };

    #vaultwarden-src = {
    #  url = "github:dani-garcia/vaultwarden/1.37.3";
    #  flake = false;
    #};
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs_unstable,
      home-manager,
      prism,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
      pkgsPath = nixpkgs.outPath;

      pkgs_bleeding = import nixpkgs_unstable {
        system = "${system}";
        config.allowUnfree = true;
      };
      pkgsPath_bleeding = nixpkgs_unstable.outPath;

      packages = {
        x86_64-linux = nixpkgs.legacyPackages.${system};
      };
      lib = nixpkgs.lib;
    in
    {
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

              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit pkgsPath;
                #inherit pkgsPath_bleeding;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit prism;
            inherit pkgs_bleeding;
          };
        };
      };

      nixpkgs.overlays = (
        final: prev: {
          vaultwarden = prev.vaultwarden.overrideAttrs (old: {
            version = "1.37.3";
            src = inputs.vaultwarden-src;

            cargoDeps = old.cargoDeps.overrideAttrs {
              src = inputs.vaultwarden-src;
              outputHash = lib.fakeHash;
            };
          });
        }
      );
    };
}

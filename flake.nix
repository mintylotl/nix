{
  description = "Home Manager Configuration";

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

      #nixos24 = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system:
      #import inputs.nixos24{
      #inherit system;
      #config.allowUnfree = true;
      #});
      #nix24 = nixos24.x86_64-linux;
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

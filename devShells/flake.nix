{
  description = "Integrated DevShells";

  nixConfig = {
    extra-substituters =
      [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
    ];
  };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/611bf8f183e6360c2a215fa70dfd659943a9857f";
    };
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system} = {
        blender3 = pkgs.mkShell {
          buildInputs = [ pkgs.blender ];
          shellHook = "echo Blender3 DevShell Initialized";
        };
      };
    };
}

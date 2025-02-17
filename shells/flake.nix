{
  description = "Integrated DevShells";
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
        blender3 = pkgs.mkshell {
          buildInputs = [ pkgs.blender ];
          shellHook = "echo Blender3 DevShell Initialized";
        };
      };
    };
}

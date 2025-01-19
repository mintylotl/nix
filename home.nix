{ config, pkgs, lib, ... }:
let HOME = "/home/jwm";
in {
  imports = [
    # Services
    ./services_user.nix
    ./programs/fish.nix
  ];

  home.username = "panda";
  home.homeDirectory = "/home/panda";
  home.preferXdgDirectories = false;
  programs.home-manager.enable = true;

  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  home.file = {
    # Scripts & Folders
    ".scripts" = {
      source = ./dots/scripts;
      recursive = true;
    };
  };

  # Programs
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = "";
    initExtra = ''
      fish
    '';
    profileExtra = "";
  };

  programs.neovim = { enable = true; };

  programs.kitty.enable = true;
  programs.fish.enable = true;
  programs.alacritty.enable = true;

  programs.git = {
    enable = true;
    userName = "mintylotl";
    userEmail = "mintyaxolotl@proton.me";
  };

  home.stateVersion = "24.05";
}

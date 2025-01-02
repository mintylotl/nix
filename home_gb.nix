{ lib, pkgs, ... }:
let HOME = "/home/gameboy";
in {
  imports = [ ./programs/zsh.nix ./home/xdg.nix ];

  home.username = "gameboy";
  home.homeDirectory = "/home/gameboy";
  programs.home-manager.enable = true;

  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  home.file = {
    ".config/pipewire" = {
      source = ./dots/config/pipewire;
      recursive = true;
    };
    ".asoundrc" = { source = ./dots/config/asoundrc; };
  };

  # Programs
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.emacs.enable = true;
  services.emacs.enable = false;

  programs.bash = {
    enable = true;
    initExtra = ''
      zsh
    '';
    profileExtra = ''
      if [[ $- == *i* ]];
      then
        exec startplasma-wayland
      fi
    '';
  };

  programs.neovim = { enable = true; };

  programs.kitty.enable = true;
  programs.alacritty.enable = true;
  programs.rofi = {
    enable = true;
    theme = ./config/dracula.rasi;
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };

  home.stateVersion = "24.05";
}

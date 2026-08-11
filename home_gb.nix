{
  lib,
  pkgs,
  pkgsPath,
  #pkgsPath_bleeding,
  ...
}:
let
  HOME = "/home/gameboy";
in
{
  imports = [ ./programs/zsh.nix ];

  home.username = "gameboy";
  home.homeDirectory = "/home/gameboy";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.file = {
    #".config/pipewire" = {
    #  source = ./dots/config/pipewire;
    #  recursive = true;
    #};
    #".scripts/sink.sh" = {
    #  source = ./dots/config/hypr/sink.sh;
    #};
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
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
      alias e="exit"
      zsh
    '';
    profileExtra = ''
      if [[ $- == *i* ]];
      then
        export WLR_NO_HARDWARE_CURSORS=1
        export WLR_RENDERER=
        export WLR_DRM_NO_ATOMIC=1
        export GBM_BACKEND=nvidia-drm
        export XDG_CURRENT_DESKTOP=labwc
        export XDG_SESSION_TYPE=wayland
      fi
    '';
  };

  programs.neovim = {
    enable = true;
  };

  programs.kitty.enable = true;
  programs.alacritty.enable = true;
  programs.rofi = {
    enable = true;
    theme = ./config/dracula.rasi;
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };

  nix.registry = {
    devShells = {
      from = {
        id = "devShells";
        type = "indirect";
      };
      to = {
        type = "path";
        path = "/etc/nixos/devShells";
      };
    };
    nixos = {
      from = {
        id = "nixos";
        type = "indirect";
      };
      to = {
        type = "path";
        path = pkgsPath;
      };
    };
    #nixosBleed = {
    #  from = {
    #    id = "nixosbleed";
    #    type = "indirect";
    #  };
    #  to = {
    #    type = "path";
    #    path = pkgsPath_bleeding;
    #  };
    #};
  };

  programs.waybar.enable = true;

  home.stateVersion = "24.05";
}

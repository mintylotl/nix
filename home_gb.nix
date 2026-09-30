{
  lib,
  config,
  pkgs,
  pkgsPath,
  #pkgsPath_bleeding,
  ...
}:
{
  imports = [
    ./home/xdg_gameboy.nix
    ./programs/zsh_gameboy.nix
  ];

  home.username = "gameboy";
  home.homeDirectory = "/home/gameboy";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    #STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
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
    enable = false;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };

  services.emacs.enable = false;
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    emacs.enable = true;

    bash = {
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

    neovim = {
      enable = true;
    };

    kitty.enable = true;
    alacritty.enable = true;
    rofi = {
      enable = true;
      theme = ./config/dracula.rasi;
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };
    waybar.enable = true;
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

  home.stateVersion = "26.05";
}

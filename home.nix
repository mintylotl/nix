{
  config,
  lib,
  pkgs,
  pkgsPath,
  pkgsPath_bleeding,
  inputs,
  ...
}:
let
  HOME = "/home/jwm";
in
{
  home.username = "jwm";
  home.homeDirectory = "/home/jwm";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager = {
    enable = true;
    path = "/etc/nixos/home.nix";
  };

  imports = [
    ./home/xdg.nix

    ./programs/zsh.nix
    ./config/hyprland-conf.nix
    ./programs/emacs.nix

    ./services_user.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
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
    nixosBleed = {
      from = {
        id = "nixosbleed";
        type = "indirect";
      };
      to = {
        type = "path";
        path = pkgsPath_bleeding;
      };
    };
  };

  home.file = {
    # Scripts & Folders
    ".scripts" = {
      source = ./dots/scripts;
      recursive = true;
    };
    "Downloads/Youtube" = {
      source = ./dots/scripts_dl/Youtube;
      recursive = true;
    };
    # Programs
    ".programs" = {
      source = ./dots/programs;
      recursive = true;
    };

    # Configuration
    ".config/mpv" = {
      source = ./dots/config/mpv;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./dots/config/waybar;
      recursive = true;
    };
    /*
      ".config/pipewire" = {
        source = ./dots/config/pipewire;
        recursive = true;
      };
    */
  };
  # Services
  services.mpd = {
    enable = true;
    musicDirectory = "${HOME}/Music";
    dataDir = "/system/programs/mpd";
    dbFile = "/system/programs/mpd/library.db";

    network = {
      port = 37388;
    };
  };

  # Programs
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = "";
    initExtra = ''
      alias e="exit"
      zsh
    '';
    profileExtra = "";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
    package = pkgs.rofi-wayland;
  };

  programs.git = {
    enable = true;
    userName = "mintylotl";
    userEmail = "mintyaxolotl@proton.me";
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  home.pointerCursor = {
    x11.enable = true;

    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 24;
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-menu-images = true;
    };

    gtk4.extraConfig = {
      gtk-menu-images = true;
    };

    cursorTheme.name = "BreezeX-RosePineDawn-Linux";
    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "Breeze-Dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
    style.package = pkgs.qt6Packages.qtstyleplugin-kvantum;
  };

  home.stateVersion = "24.05";
}

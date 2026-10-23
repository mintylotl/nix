{
  config,
  lib,
  pkgs,
  pkgsPath,
  pkgsPath_bleeding,
  inputs,
  ...
}:
{
  home.username = "jwm";
  home.homeDirectory = "/home/jwm";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./home/xdg.nix
    ./home/daemons.nix

    ./programs/zsh.nix
    ./config/hyprland-conf.nix
    ./programs/emacs.nix

    ./services_user.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  programs = {
    home-manager = {
      enable = false;
      path = "/etc/nixos/home_jwm.nix";
    };
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
  };

  # Programs
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    waybar = {
      enable = true;
      systemd.enable = false;
    };

    bash = {
      enable = true;
      bashrcExtra = "";
      initExtra = ''
        alias e="exit"
        zsh
      '';
      profileExtra = "";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    neovim = {
      enable = true;

      withPython3 = false;
      withRuby = false;
    };

    kitty.enable = true;
    alacritty = {
      enable = true;
      #settings = {
      #  window.dimensions = {
      #    lines = 15;
      #    columns = 600;
      #  };
      #};
    };
    rofi = {
      enable = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      package = pkgs.rofi;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "mintylotl";
          email = "mintyaxolotl@proton.me";
        };
      };
    };
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # THEMING
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 24;
  };

  gtk = {
    enable = true;

    gtk3 = {
      extraConfig = {
        gtk-menu-images = true;
        gtk-application-prefer-dark-theme = true;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-menu-images = true;
        gtk-application-prefer-dark-theme = true;
      };
    };

    cursorTheme.name = "BreezeX-RosePineDawn-Linux";
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
    style.name = "kvantum";
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "mauve";

    gtk = {
      icon.enable = false;
    };
    kvantum = {
      enable = true;
      apply = true;
    };
    rofi.enable = true;
    alacritty.enable = false;
  };

  home.stateVersion = "26.05";
}

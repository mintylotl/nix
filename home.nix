{ config, pkgs, lib, ... }:
let HOME = "/home/jwm";
in {
  imports = [
    # Programs
    ./config/hyprland-conf.nix
    ./programs/zsh.nix
    ./programs/emacs.nix
  ];

  home.username = "jwm";
  home.homeDirectory = "/home/jwm";
  home.preferXdgDirectories = true;
  programs.home-manager.enable = true;

  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  home.file = {
    ".scripts" = {
      source = ./dots/scripts;
      recursive = true;
    };
    "Downloads/Youtube" = {
      source = ./dots/scripts_dl/Youtube;
      recursive = true;
    };
    ".config/mpv" = {
      source = ./dots/config/mpv;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./dots/config/waybar;
      recursive = true;
    };
    #".ecryptfs" = {
    #  source = ./dots/ecryptfs;
    #  recursive = true;
    #};
    ".config/pipewire" = {
      source = ./dots/config/pipewire;
      recursive = true;
    };
    ".asoundrc" = { source = ./dots/config/asoundrc; };
  };

  # Home Stuff
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = false;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config.common.default = "gtk";
      config.hyprland = {
        default = "hyprland";
        "org.freedesktop.impl.Screencast" = "hyprland";
        "org.freedesktop.impl.Screenshot" = "hyprland";
      };
    };

    configHome = "${HOME}/.config";
    cacheHome = "${HOME}/.cache";
    dataHome = "${HOME}/.local/share";
    stateHome = "${HOME}/.local/state";

    userDirs.createDirectories = true;
  };

  # Programs
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;
  };
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="${HOME}/.emacs.d/bin:$PATH"
      export PATH="${HOME}/.scripts/scripts/"
    '';
    initExtra = ''
      zsh
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

  programs.git = {
    enable = true;
    userName = "mintylotl";
    userEmail = "mintyaxolotl@proton.me";
  };

  # Hyprland
  home.pointerCursor = {
    x11.enable = true;

    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 24;
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = { gtk-menu-images = true; };

    gtk4.extraConfig = { gtk-menu-images = true; };

    cursorTheme.name = "BreezeX-RosePineDawn-Linux";
    theme = {
      package = pkgs.breeze-gtk;
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

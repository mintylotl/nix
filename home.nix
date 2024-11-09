{ 
  config, pkgs, lib,
  ...
}:
let 
HOME = "/home/jwm";
in {
  imports = [ 
    ./config/hyprland-conf.nix
    ./programs/zsh.nix
  ];
  
  home.username = "jwm";
  home.homeDirectory = "/home/jwm";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERM = "alacritty";
    NIXOS_OZONE_WL = "1";
  };
  
  home.file = {
    ".scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };

  # Home Stuff
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = false;
    
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "gtk";
    };

    configHome = "${HOME}/.config";
    cacheHome = "${HOME}/.cache";
    dataHome = "${HOME}/.local/share";
    stateHome = "${HOME}/.local/state";

    userDirs.createDirectories = true;
  };
  
  # Programs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  programs.waybar = {
    enable = true;
    systemd.enable = false;
    systemd.target = "hyprland-session.target";
  };
  
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      zsh
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

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
